import 'package:actual2/common/view/splash_screen.dart';
import 'package:actual2/user/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      home: SplashScreen(),
    );
  }
}
