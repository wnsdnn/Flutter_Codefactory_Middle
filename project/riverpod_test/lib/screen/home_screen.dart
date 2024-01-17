import 'package:flutter/material.dart';
import 'package:riverpod_test/layout/default_layout.dart';
import 'package:riverpod_test/screen/state_provider_scree.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StateProviderScreen(),
                ),
              );
            },
            child: Text('StateProviderScreen'),
          ),
        ],
      ),
    );
  }
}
