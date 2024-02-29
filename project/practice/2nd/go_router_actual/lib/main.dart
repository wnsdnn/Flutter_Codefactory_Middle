import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_actual/screen/1_screen.dart';
import 'package:go_router_actual/screen/2_screen.dart';
import 'package:go_router_actual/screen/3_screen.dart';
import 'package:go_router_actual/screen/error_screen.dart';
import 'package:go_router_actual/screen/home_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  GoRouter get _router => GoRouter(
        initialLocation: '/',
        errorBuilder: (context, state) => ErrorScreen(
          error: state.error.toString(),
        ),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomeScreen(),
            routes: [
              GoRoute(
                path: 'one',
                builder: (context, state) => OneScreen(),
                routes: [
                  GoRoute(
                    path: 'two',
                    builder: (context, state) => TwoScreen(),
                    routes: [
                      GoRoute(
                        path: 'three',
                        name: 'three',
                        builder: (context, state) => ThreeScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 라우터 정보를 리턴
      // routeInformationProvider: _router.routeInformationProvider,
      // URI String을 상태 및 Go Router에서 사용할 수 있는 형태로
      // 변환해주는 함수
      // routeInformationParser: _router.routeInformationParser,
      // 위에서 변경된 값으로
      // 실제 어떤 라우트를 보여줄지
      // 정하는 함수
      // routerDelegate: _router.routerDelegate,

      routerConfig: _router,
    );
  }
}
