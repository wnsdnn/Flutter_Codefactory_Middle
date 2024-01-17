import 'package:flutter_riverpod/flutter_riverpod.dart';

// 캐시 남기지 않고 지움
final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1, 2, 3, 4, 5];
});