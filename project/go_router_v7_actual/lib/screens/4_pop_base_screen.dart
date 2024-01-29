import 'package:flutter/material.dart';
import 'package:go_router_v7_actual/layout/default_layout.dart';

class PopScreen extends StatelessWidget {
  const PopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {

            },
            child: Text('Pop Base Screen'),
          ),
        ],
      ),
    );
  }
}
