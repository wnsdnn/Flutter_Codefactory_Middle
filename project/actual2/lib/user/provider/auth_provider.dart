import 'package:actual2/common/view/root_tab.dart';
import 'package:actual2/common/view/splash_screen.dart';
import 'package:actual2/restaurant/view/restaurant_detail_screen.dart';
import 'package:actual2/user/model/user_model.dart';
import 'package:actual2/user/provider/user_me_provider.dart';
import 'package:actual2/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) {
    return AuthProvider(
      ref: ref,
    );
  },
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        // userMeProvider에서의 변경사항이 생겼을때만
        // AuthProvider(this)에서도 변경사항이 생겼다고 알려줌
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (context, state) => RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid/:name',
              builder: (context, state) {
                return RestaurantDetailScreen(
                  id: state.pathParameters['rid']!,
                  name: state.pathParameters['name']!,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) => LoginScreen(),
        ),
      ];

  // SplashScreen
  // 앱을 처음 시작했을때
  // 토근이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(_, GoRouterState state) {
    // user 상태
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.location == '/login';

    // 유저 정보가 없는데
    // 로그인중이면 그대로 로그인 페이지에 두고
    // 만약에 로그인중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user가 null이 아님

    // UserModel인 상태
    // 사용자 정보가 있는 상태면
    // 로그인 중이거나 현재 위치가 SplashScreen이면
    // 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/spash' ? '/' : null;
    }

    // UserModelError인 상태
    // 로그인 중이 아니라면 로그인화면으로 이동
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}
