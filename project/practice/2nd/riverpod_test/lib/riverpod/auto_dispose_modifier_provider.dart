import 'package:flutter_riverpod/flutter_riverpod.dart';


// autoDispose - 자동으로 메모리에서 삭제 (캐싱 기능 X)
final autoDisposeModifierProvider =
    FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1, 2, 3, 4, 5];
});
