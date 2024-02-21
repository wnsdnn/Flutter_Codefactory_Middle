import 'package:actual2/common/model/cursor_pagination_model.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    return RestaurantStateNotifier(
      repository: repository,
    );
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    // RestaurantStateNotifier가 생성되자마자 paginate() 함수 실행
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();

    // api에서 호출해온 값을 바로 state에 저장
    state = resp;
  }
}
