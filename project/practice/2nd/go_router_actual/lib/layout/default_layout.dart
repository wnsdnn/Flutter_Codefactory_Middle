import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).location;

    return Scaffold(
      appBar: AppBar(
        title: Text(location.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: body,
      ),
    );
  }
}
