import 'package:flutter_riverpod/flutter_riverpod.dart';

// .fmaily를 쓰는 순간 재너릭과 콜백함수의 두번째 매개변수의 값을 추가해야함
// provider를 생성하는 순간에 어떤 변수를 입력해서 그 변수의 값으로 provider 로직을 변경해야할때 family를 씀
final familyModifierProvider = FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(Duration(seconds: 2));

  return List.generate(5, (index) => index * data);

  return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
});