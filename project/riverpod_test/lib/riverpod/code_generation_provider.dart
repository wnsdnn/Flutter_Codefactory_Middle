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


// 2) Parameter > Family
// 파라미터를 일반 함수처럼 사용할 수 있도록 (2개 이상)


