import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screen/1_basic_screen.dart';
import 'package:go_router_v7_actual/screen/2_named_screen.dart';
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
      ],
    ),
  ],
);
