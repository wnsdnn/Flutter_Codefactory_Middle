import 'package:actual2/common/model/cursor_pagination_model.dart';
import 'package:actual2/common/model/pagination_params.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
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

  void paginate({
    int fetchCount = 20,
    // 추가로 데이터 더 가져오기 (추가 데이터 가져오기)
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기 (초기화)
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    // 5가지 가능성
    // State의 상태
    // [상태가]
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
    // 3) CursorPaginationError - 에러가 있는 상태
    // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
    // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라고 요청을 받았을때

    // 바로 반환하는 상환
    // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
    // 2) 로딩중 - fetchMore: true
    //    fetchMore가 아닐때 - 새로고침의 의도가 있을수 있다 (데이터가 불러와지는 도중에 위로 올려서 취소할려고 할때)

    // 1번 반황 상황
    if (state is CursorPagination && !forceRefetch) {
      final pState = state as CursorPagination;

      // meta에 hasMore 값에 false면 반환
      if (!pState.meta.hasMore) {
        return;
      }
    }

    final isLoading = state is CursorPaginationLoading;
    final isRefetching = state is CursorPaginationRefetching;
    final isFetchingMore = state is CursorPaginationFetchingMore;

    // 2번 반환 상황
    if (!fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      return;
    }

    // PaginationParams 생성
    PaginationParams paginationParams = PaginationParams(
      count: fetchCount,
    );

    // fetchingMore
    // 데이터를 추가로 더 가져오는 상황
    if (fetchMore) {
      final pState = state as CursorPagination;

      state = CursorPaginationFetchingMore(
        meta: pState.meta,
        data: pState.data,
      );

      paginationParams = paginationParams.copywith(
        after: pState.data.last.id,
      );
    }

    final resp = await repository.paginate(
      paginationParams: paginationParams,
    );

    if (state is CursorPaginationFetchingMore) {
      final pState = state as CursorPaginationFetchingMore;

      // 기존 데이터에
      // 새로운 데이터 추가
      state = resp.copywith(
        data: [
          ...pState.data,
          ...resp.data,
        ],
      );
    }

  }
}
