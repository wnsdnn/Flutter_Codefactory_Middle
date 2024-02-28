import 'package:actual2/common/const/data.dart';
import 'package:actual2/common/dio/dio.dart';
import 'package:actual2/common/model/login_response.dart';
import 'package:actual2/common/model/token_response.dart';
import 'package:actual2/common/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(dio: dio, baseUrl: 'http://$ip/auth');
});

// http://$ip/auth
class AuthRepository {
  final Dio dio;
  final String baseUrl;

  AuthRepository({
    required this.dio,
    required this.baseUrl,
  });

  // 로그인 해주는 함수
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );

    // 반환받은 토큰값 인스턴스로 생성후 리턴
    return LoginResponse.fromJson(resp.data);
  }

  // accessToken 발급해주는 함수
  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {
          'refreshToken': 'true',
        },
      ),
    );

    return TokenResponse.fromJson(resp.data);
  }
}
