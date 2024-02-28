import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: body,
      ),
    );
  }
}
