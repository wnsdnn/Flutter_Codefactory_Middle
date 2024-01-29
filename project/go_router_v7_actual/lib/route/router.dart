import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screens/1_basic_scree.dart';
import 'package:go_router_v7_actual/screens/2_named_screen.dart';
import 'package:go_router_v7_actual/screens/3_push_screen.dart';
import 'package:go_router_v7_actual/screens/4_pop_base_screen.dart';
import 'package:go_router_v7_actual/screens/5_pop_return_screen.dart';
import 'package:go_router_v7_actual/screens/6_path_param_screen.dart';
import 'package:go_router_v7_actual/screens/7_query_parameter_screen.dart';
import 'package:go_router_v7_actual/screens/8_nested_child_screen.dart';
import 'package:go_router_v7_actual/screens/8_nested_screen.dart';
import 'package:go_router_v7_actual/screens/root_screen.dart';

// https://blog.codefactory.ai -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
final router = GoRouter(
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
              builder: (context, state) => NestedChildScreen(routeName: '/nested/a'),
            ),
            // /nested/b
            GoRoute(
              path: 'nested/b',
              builder: (context, state) => NestedChildScreen(routeName: '/nested/b'),
            ),
            // /nested/c
            GoRoute(
              path: 'nested/c',
              builder: (context, state) => NestedChildScreen(routeName: '/nested/c'),
            ),
          ],
        ),
      ],
    ),
  ],
);
