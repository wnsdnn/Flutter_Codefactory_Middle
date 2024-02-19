import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/layout/default_layout.dart';
import 'package:riverpod_test/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');

    // 불러올 Provider는 개발자가 선언한 함수명이 아닌 .g.dart 파일에 생성된 Provider를 가져와야 한다.
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(
      number1: 10,
      number2: 20,
    ));

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('State1: $state1'),
          state2.when(
            data: (data) => Text('State2: $data'),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          state3.when(
            data: (data) => Text('State3: $data'),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text('State4: $state4'),
          // Consumer - build 함수 안에다가 부분적으로 반환해주고 싶은값을 리턴해주면 됨
          Consumer(
            builder: (context, ref, child) {
              print('builder build');
              final state5 = ref.watch(gStateNotifierProvider);

              return Row(
                children: [
                  Text('State5: $state5'),
                  if(child != null) child,
                ],
              );
            },
            // child의 값은 딱 1번만 렌더링 된다
            // build가 다시 실행되도 렌더링 안함
            // 렌더링할때 비용이 많이 드는 위젯들을 보통 집어넣음
            child: Text('Hello'),
          ),
          // _StateFiveWidget(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).increment();
                },
                child: Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).decrement();
                },
                child: Text('Decrement'),
              ),
            ],
          ),
          // invalidate() - 유효하지 않게 한다
          // 초기상태로 돌아가게 한다
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text('Invalidate'),
          ),
        ],
      ),
    );
  }
}

class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);

    return Text('State5: $state5');
  }
}
