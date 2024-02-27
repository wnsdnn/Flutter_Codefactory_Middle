import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screen/1_basic_screen.dart';
import 'package:go_router_v7_actual/screen/2_named_screen.dart';
import 'package:go_router_v7_actual/screen/3_push_screen.dart';
import 'package:go_router_v7_actual/screen/4_pop_base_screen.dart';
import 'package:go_router_v7_actual/screen/5_pop_return_screen.dart';
import 'package:go_router_v7_actual/screen/6_path_params_screen.dart';
import 'package:go_router_v7_actual/screen/root_screen.dart';

// http://blog.codefactory.ai -> /
// https://blog.codefactory.ai/flutter -> /flutter
// / -> home
// /basic -> basic screen
// /named -> named screen
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
      ],
    ),
  ],
);
