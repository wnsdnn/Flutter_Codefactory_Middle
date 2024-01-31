import 'package:actual/common/provider/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      routerConfig: route,
      // routerDelegate: route.routerDelegate,
      // routeInformationParser: route.routeInformationParser,
      // routeInformationProvider: route.routeInformationProvider,
      // home: SplashScreen(),
    );
  }
}
