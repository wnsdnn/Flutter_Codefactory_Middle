import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screen/10_transition_screen_1.dart';
import 'package:go_router_v7_actual/screen/10_transition_screen_2.dart';
import 'package:go_router_v7_actual/screen/11_error_screen.dart';
import 'package:go_router_v7_actual/screen/1_basic_screen.dart';
import 'package:go_router_v7_actual/screen/2_named_screen.dart';
import 'package:go_router_v7_actual/screen/3_push_screen.dart';
import 'package:go_router_v7_actual/screen/4_pop_base_screen.dart';
import 'package:go_router_v7_actual/screen/5_pop_return_screen.dart';
import 'package:go_router_v7_actual/screen/6_path_params_screen.dart';
import 'package:go_router_v7_actual/screen/7_query_parameter.dart';
import 'package:go_router_v7_actual/screen/8_child_screen.dart';
import 'package:go_router_v7_actual/screen/8_nested_screen.dart';
import 'package:go_router_v7_actual/screen/9_login_screen.dart';
import 'package:go_router_v7_actual/screen/9_private_screen.dart';
import 'package:go_router_v7_actual/screen/root_screen.dart';

// 로그인이 됐는지 안됐는지
// ture - login OK / false - login NO
// http://blog.codefactory.ai -> /
// https://blog.codefactory.ai/flutter -> /flutter
// / -> home
// /basic -> basic screen
// /named -> named screen
final router = GoRouter(
  redirect: (context, state) {
    // return string - > 해당 라우트로 이동한다 (path)
    // return null -> 원래 이동하려던 라우트로 이동한다.
    if (state.location == '/login/private' && !authState) {
      // location이 '/login/private' 이고 authState가 false면
      // 다시 '/login'으로 이동
      return '/login';
    }

    return null;
  },
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RootScreen(),
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) => BasicScreen(),
        ),
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, state) => NamedScreen(),
        ),
        GoRoute(
          path: 'push',
          builder: (context, state) => PushScreen(),
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) => PopBaseScreen(),
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) => PopReturnScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'path_params/:id', // /path_params/123
          builder: (context, state) => PathParamsScreen(),
          routes: [
            GoRoute(
              path: ':name',
              builder: (context, state) => PathParamsScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) => QueryParameterScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) => NestedScreen(child: child),
          routes: [
            // /nested/a -> 이걸로 해석
            GoRoute(
              path: 'nested/a',
              builder: (context, state) =>
                  NestedChildScreen(routeName: 'nested/a'),
            ),
            GoRoute(
              path: 'nested/b',
              builder: (context, state) =>
                  NestedChildScreen(routeName: 'nested/b'),
            ),
            GoRoute(
              path: 'nested/c',
              builder: (context, state) =>
                  NestedChildScreen(routeName: 'nested/c'),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => PrivateScreen(),
              // 해당 부분에서만 redirect 적용
              redirect: (context, state) {
                // 현재 location이 /login2일때만 실행되므로
                // authState에 관한 내용만 쓰면됨
                if (!authState) {
                  return '/login2';
                }

                return null;
              },
            ),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (context, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              pageBuilder: (context, state) => CustomTransitionPage(
                transitionDuration: Duration(seconds: 3),
                // animation - 화면이 전환이 될때 0에서 1로 점점 증가함
                // secondaryAnimation - animation의 반대
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // return RotationTransition(
                  //   turns: animation,
                  //   child: child,
                  // );
                  // return ScaleTransition(
                  //   scale: animation,
                  //   child: child,
                  // );
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: TransitionScreenTwo(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

bool authState = false;
