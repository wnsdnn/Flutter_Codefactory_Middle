import 'package:actual2/common/const/colors.dart';
import 'package:actual2/common/const/data.dart';
import 'package:actual2/common/dio/dio.dart';
import 'package:actual2/common/layout/default_layout.dart';
import 'package:actual2/common/secure_storage/secure_storage.dart';
import 'package:actual2/common/view/root_tab.dart';
import 'package:actual2/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void deleteToken() async {
    final storage = ref.read(secureStorageProvider);
    
    await storage.deleteAll();
  }

  void checkToken() async {
    final dio = ref.read(dioProvider);
    final storage = ref.read(secureStorageProvider);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    await Future.delayed(Duration(seconds: 1));

    try {
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            }
        ),
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => RootTab(),
        ),
            (route) => false,
      );
    } catch(e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 16.0),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
