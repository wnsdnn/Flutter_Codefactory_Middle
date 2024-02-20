import 'package:actual2/common/const/data.dart';
import 'package:actual2/common/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomeInterceptor(
      storage: storage,
    ),
  );

  return dio;
});

class CustomeInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomeInterceptor({
    required this.storage,
  });

  // 1) 요청을 보낼때 (요청이 보내지기전)
  // 요청이 보내질때마다
  // 만약에 요청의 Header에 accessToken: true라는 값이 있다면
  // 실제 토큰을 가져와서 (storage에서) authorization: Bearer $token으로
  // 헤더를 변경한다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      // 기존에 Headers에 accessToken 값 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰 삽입
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  // 정상적인 응답이 왔을떄만 실행
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 에러가 있을때 (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 아예 없으면
    // 당연히 에러를 던진다.
    if (refreshToken == null) {
      // 에러 돌려주기
      // 에러를 던질때는 handler.reject를 사용한다.
      handler.reject(err);

      return;
    }

    // statusCode값이 401에러인지(토큰 만료) 확인
    final isStatus401 = err.response?.statusCode == 401;

    // 토큰을 발급 받다가 오류가 난건지 확인
    // 만약 아래 코드가 맞다면 현재 가지고 있는 refreshToken이 잘못되어있다는 결론이 남
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        // 오류가 났던 요청에 Headers에 accessToken값 새로 할당
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        // storage에 accessToken값 재할당
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송
        final response = await dio.fetch(options);

        // 요청 성공 여부 리턴
        return handler.resolve(response);
      } on DioError catch (e) {
        // 만약 accessToken 값을 다시 발급 받는 경우에 오류가 났다면
        // 해당 refreshToken 값이 잘못되었다는 뜻이다.
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }
}
