import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/layout/default_layout.dart';
import 'package:riverpod_test/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(
      number1: 10,
      number2: 20,
    ));
    final state5 = ref.watch(gStateNotifierProvider);

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'State1: $state1',
            ),
            state2.when(
              data: (data) => Text('State2: $data'),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator(),
            ),
            state3.when(
              data: (data) => Text('State3: $data'),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => CircularProgressIndicator(),
            ),
            Text(
              'State4: $state4',
            ),
            Text(
              'State5: $state5',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            // invalidate()
            // 유효하지 않게 하다
            ElevatedButton(
              onPressed: () {
                // 맨처음(초기화) 상태로 돌아가게함
                ref.invalidate(gStateNotifierProvider);
              },
              child: Text('Invalidate'),
            ),
          ],
        ),
      ),
    );
  }
}
