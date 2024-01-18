import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider를 사용할지 결정할 고민을 할 필요 없도록
// Provider, FutureProvider, StreamProvider(22년 기준으로는 안됨 x)
// StateNotifierProvider는 명시적으로 code generation을 할수 있음

// 기존 Provider 선언 방법
final _testProvider = Provider<String>((ref) => 'Hello Code Generation');

// Code Generation을 사용한 새로운 방법 (함수를 선언하는것 처럼 선언)
@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}

@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

@Riverpod(
  // 살려둬라 (기본이 false)
  // false - FutureProvider
  // true - AutoDisposeFutureProvider
  keepAlive: true,
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

// 2) Parameter > Family
// 파라미터를 일반 함수처럼 사용할 수 있도록 (2개 이상)

// 기존 Family 쓰는 방법 (파라미터 2개 이상 받고 싶을때)
class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}

final _testFamilyProvider = Provider.family<int, Parameter>(
  (ref, parameter) => parameter.number1 * parameter.number2,
);

// v2로 넘어왔을때 사용방법
@riverpod
int gStateMultiply(
  GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}
