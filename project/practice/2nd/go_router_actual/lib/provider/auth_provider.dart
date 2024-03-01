import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_actual/model/user_model.dart';
import 'package:go_router_actual/screen/1_screen.dart';
import 'package:go_router_actual/screen/2_screen.dart';
import 'package:go_router_actual/screen/3_screen.dart';
import 'package:go_router_actual/screen/error_screen.dart';
import 'package:go_router_actual/screen/home_screen.dart';
import 'package:go_router_actual/screen/login_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateProvider = AuthNotifier(
    ref: ref,
  );

  return GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorScreen(
      error: state.error.toString(),
    ),
    // redirect
    redirect: authStateProvider._redirectLogic,
    // refresh
    // refreshListenable - 해당 값의 변경이 있으면
    // redirect 실행
    // (refreshListenable 없으면 redirect는 네이비게이션 이동일때만 실행됨)
    refreshListenable: authStateProvider,
    routes: authStateProvider._routes,
  );
});

//
// 일반 클래스처러 사용
class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({required this.ref}) {
    ref.listen(
      userProvider,
      (previous, next) {
        if (previous != next) {
          // notifyListeners가 실행되면 ChangeNotifier를 상속받은 클래스를
          // 바라보고 있는 모든 위젯이 rebuile 됨.
          notifyListeners();
        }
      },
    );
  }

  String? _redirectLogic(_, GoRouterState state) {
    // UserModel의 인스턴스 또는 null
    final user = ref.read(userProvider);

    // 로그인을 하려는 상태인지
    final loggingIn = state.location == '/login';

    // 유저 정보가 없다 - 로그인한 상태가 아니다
    //
    // 유저 정보가 없고
    // 로그인하려는 중이 아니라면
    // 로그인 페이지로 이동한다.
    if(user == null) {
      return loggingIn ? null : '/login';
    }

    // 유저 정보가 있는데
    // 로그인 페이지라면
    // 홈으로 이동
    if(loggingIn) {
      return '/';
    }

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
          routes: [
            GoRoute(
              path: 'one',
              builder: (context, state) => OneScreen(),
              routes: [
                GoRoute(
                  path: 'two',
                  builder: (context, state) => TwoScreen(),
                  routes: [
                    GoRoute(
                      path: 'three',
                      name: 'three',
                      builder: (context, state) => ThreeScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
      ];
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
  (ref) {
    return UserStateNotifier();
  },
);

// 로그인한 상태면 userModel 인스턴스 상태로 넣어주기
// 로그아웃 상태면 null 상태로 넣어주기
class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  login({
    required String name,
  }) {
    state = UserModel(
      name: name,
    );
  }

  logout() {
    state = null;
  }
}
