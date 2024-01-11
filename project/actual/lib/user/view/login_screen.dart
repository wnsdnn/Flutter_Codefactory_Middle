import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logoWidth = (MediaQuery.of(context).size.width / 3) * 2;

    return DefaultLayout(
      child: SingleChildScrollView(
        // 키보드 활성화 상태에 화면 드래그시 키보드 비활성화로 변경
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(height: 6.0),
                _SubTitle(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'asset/img/misc/logo.png',
                    width: logoWidth,
                  ),
                ),
                SizedBox(height: 12.0),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {},
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  onChanged: (String value) {},
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
