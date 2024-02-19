import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/layout/default_layout.dart';
import 'package:riverpod_test/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 불러올 Provider는 개발자가 선언한 함수명이 아닌 .g.dart 파일에 생성된 Provider를 가져와야 한다.
    final state1 = ref.watch(gStateProvider);

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        children: [
          Text('State1: $state1'),
        ],
      ),
    );
  }
}
