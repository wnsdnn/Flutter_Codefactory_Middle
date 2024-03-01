import 'package:actual2/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    // watch - 값이 변경될때마다 다시 빌드
    // read - 한번만 읽고 값이 변경되도 다시 빌드하지 않음
    final provider = ref.read(authProvider);

    return GoRouter(
      initialLocation: '/splash',
      routes: provider.routes,
      refreshListenable: provider,
      redirect: provider.redirectLogic
    );
  },
);
