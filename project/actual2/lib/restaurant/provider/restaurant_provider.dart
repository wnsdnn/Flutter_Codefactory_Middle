import 'package:actual2/common/model/cursor_pagination_model.dart';
import 'package:actual2/common/provider/pagination_provider.dart';
import 'package:actual2/restaurant/model/restaurant_detail_model.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

// 레스토랑 상세페이지 Provider
final restaurantDetailProvider = Provider.family<RestaurantModel?, String>(
  (ref, id) {
    final state = ref.watch(restaurantProvider);

    // CursorPagination이 아니라면
    if (state is! CursorPagination) {
      return null;
    }

    final pState = state as CursorPagination;

    return pState.data.firstWhereOrNull((e) => e.id == id);
  },
);

// 레스토랑 목록 페이지 Provider
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    return RestaurantStateNotifier(
      repository: repository,
    );
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await this.paginate();
    }

    // state가 CursorPagination이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    // 만약 해당 클릭한 상세정보가
    // 이미 서버에 요청해서 불러온 RestaurantDetailModel이라면
    // 그냥 리턴
    if (pState.data.firstWhereOrNull((e) => e.id == id)
        is RestaurantDetailModel) {
      return;
    }

    // repository.getRestaurantDetail - RestaurantDetailModel을 반환
    final resp = await repository.getRestaurantDetail(
      id: id,
    );

    // 만약 호출한 리스트에 있는 항목중
    // ID 값이 같은 값이 있다면
    // 해당 항목은 위에서 가져온 RestaurantDetailModel로 변경한다.

    // 만약 아직 RestaurantModel을 가져오지 않은 값을 호출했을때
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // 요청 id: 10
    // list.where((e) => e.id == 10)) -> 데이터 X
    // 데이터가 없을때는 그냥 캐시의 끝에다가 데이터를 추가해버린다.
    //
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3), RestaurantDetailModel(10)]

    if (pState.data.where((e) => e.id == id).isEmpty) {
      print('없음');
      state = pState.copywith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
      print(state);
    } else {
      // before: [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
      // id: 3
      // after: [RestaurantModel(1), RestaurantDetailModel(2), RestaurantModel(3)]
      state = pState.copywith(
        data: pState.data
            .map<RestaurantModel>(
              (e) => e.id == id ? resp : e,
            )
            .toList(),
      );
    }
  }
}
