import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/screens/1_basic_scree.dart';
import 'package:go_router_v7_actual/screens/2_named_screen.dart';
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
      ],
    ),
  ],
);
