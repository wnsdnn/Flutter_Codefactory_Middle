import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_actual/layout/default_layout.dart';

class PathParamsScreen extends StatelessWidget {
  const PathParamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text('Path Params : ${GoRouterState.of(context).pathParameters}'),
          ElevatedButton(
            onPressed: () {
              context.go('/path_params/456/wnsdnn');
            },
            child: Text('Go One More'),
          ),
        ],
      ),
    );
  }
}
