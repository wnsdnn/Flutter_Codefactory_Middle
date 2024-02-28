import 'package:actual2/common/const/data.dart';
import 'package:actual2/user/model/user_model.dart';
import 'package:actual2/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // 만약 로그인이 안되어있는 상태일 경우 return
    if(refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }
}