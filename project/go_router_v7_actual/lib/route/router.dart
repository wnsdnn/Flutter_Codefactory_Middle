import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screens/10_transition_screen_1.dart';
import 'package:go_router_v7_actual/screens/10_transition_screen_2.dart';
import 'package:go_router_v7_actual/screens/1_basic_scree.dart';
import 'package:go_router_v7_actual/screens/2_named_screen.dart';
import 'package:go_router_v7_actual/screens/3_push_screen.dart';
import 'package:go_router_v7_actual/screens/4_pop_base_screen.dart';
import 'package:go_router_v7_actual/screens/5_pop_return_screen.dart';
import 'package:go_router_v7_actual/screens/6_path_param_screen.dart';
import 'package:go_router_v7_actual/screens/7_query_parameter_screen.dart';
import 'package:go_router_v7_actual/screens/8_nested_child_screen.dart';
import 'package:go_router_v7_actual/screens/8_nested_screen.dart';
import 'package:go_router_v7_actual/screens/9_login_screen.dart';
import 'package:go_router_v7_actual/screens/9_private_screen.dart';
import 'package:go_router_v7_actual/screens/root_screen.dart';

// 로그인이 됐는지 안됐는지
// true - login OK / false - login NO
bool authState = false;

// https://blog.codefactory.ai -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
final router = GoRouter(
  // 전체 적용
  redirect: (context, state) {
    // return String(path) -> 해당 라우트로 이동한다 (path)
    // return null -> 원래 이동하려던 라우트로 이동한다.

    if (state.location == '/login/private' && !authState) {
      return '/login';
    }

    return null;
  },
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
          // /pop
          path: 'pop',
          builder: (context, state) => PopBaseScreen(),
          routes: [
            GoRoute(
              // /pop/return
              path: 'return',
              builder: (context, state) => PopReturnScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'path_param/:id',
          builder: (context, state) => PathParamScreen(),
          routes: [
            GoRoute(
                path: ':name',
                builder: (context, state) {
                  return PathParamScreen();
                }),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) => QueryParameterScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            // child - ShellRoute의 routes에 넣는 GoRoute 위젯에 builder의 리턴값이 들어옴
            return NestedScreen(child: child);
          },
          routes: [
            // /nested/a
            GoRoute(
              path: 'nested/a',
              builder: (context, state) =>
                  NestedChildScreen(routeName: '/nested/a'),
            ),
            // /nested/b
            GoRoute(
              path: 'nested/b',
              builder: (context, state) =>
                  NestedChildScreen(routeName: '/nested/b'),
            ),
            // /nested/c
            GoRoute(
              path: 'nested/c',
              builder: (context, state) =>
                  NestedChildScreen(routeName: '/nested/c'),
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
              // 해당 url에 접근했을때만 redirect 실행 (부분 적용)
              redirect: (context, state) {
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
                // 시간 조절 가능
                transitionDuration: Duration(seconds: 3),
                reverseTransitionDuration: Duration(seconds: 3),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // animation - 0 ~ 1까지로 자동 증가
                  // secondaryAnimation - 1 ~ 0까지 감소 (animation과 반대, 되돌아올때)
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );return FadeTransition(
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
