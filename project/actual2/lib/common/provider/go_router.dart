import 'package:actual2/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final provider = ref.watch(authProvider);

    return GoRouter(
      initialLocation: '/splash',
      routes: provider.routes,
      refreshListenable: provider,
      redirect: provider.redirectLogic
    );
  },
);
