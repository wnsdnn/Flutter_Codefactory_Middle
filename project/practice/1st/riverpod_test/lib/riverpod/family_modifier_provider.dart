import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider 생성시 해당 Provider한테 매개변수를 전당하고 싶을때 사용
final familyModifierProvider = FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(Duration(seconds: 2));

  return List.generate(5, (index) => index * data);

  return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
});