import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청 보낼때 - 요청 보내기전에 실행
  // 요청이 보내질때마다
  // 만약 요청의 Header에 accessToken: true라는 값이 있다면
  // 실제 토큰을 가져와서 (storage에서) authorization: bearer: $token으로
  // 헤더를 변경한다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    // accessToken: true 일때
    if (options.headers['accessToken'] == 'true') {
      // accessToken 삭제
      options.headers.remove('accessToken');

      // 실제 토큰으로 대체
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    // refreshToken: true 일때
    if (options.headers['refreshToken'] == 'true') {
      // accessToken 삭제
      options.headers.remove('refreshToken');

      // 실제 토큰으로 대체
      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  // 3> 에러가 났을떄
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을때 (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 아예 없으면
    // 당연히 에러를 던진다
    if (refreshToken == null) {
      // 에러 돌려주는 방법
      // 에러를 던질때는 handler.reject를 사용한다.
      handler.reject(err);
      return;
    }

    // 401 에러일때
    final isStatus401 = err.response?.statusCode == 401;
    // token을 발급 받다가 오류 났을때
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      // 401 에러(토큰관련)이면서 토근을 발급받는 api를 호출하지 않았을때 실행
      final dio = Dio();

      try {
        final response = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = response.data['accessToken'];
        final options = err.requestOptions;

        // 기존 보낸 요청에서 accessToken값 수정
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        // 저장소의 accessToken값 수정
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송
        final reResponse = await dio.fetch(err.requestOptions);

        return handler.resolve(reResponse);
      } on DioError catch (e) {
        // token을 받을수 없는경우 (오류 났을때)
        return handler.reject(e);
      }
    }

    return handler.reject(err);
    return super.onError(err, handler);
  }
}
