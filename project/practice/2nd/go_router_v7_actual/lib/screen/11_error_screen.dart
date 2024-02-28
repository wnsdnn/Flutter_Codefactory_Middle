import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('에러'),
      ),
      body: ListView(
        children: [
          Text('Error: ${error}'),
          ElevatedButton(
            onPressed: () {
              context.go('/');
            },
            child: Text('홈으로'),
          ),
        ],
      ),
    );
  }
}
