import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/shopping_item_model.dart';
import 'package:riverpod_test/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    // 여러개의 Provider를 안에서 선언
    final shppingListState = ref.watch(shoppingListProvider);
    final filterState = ref.watch(filterProvider);

    // filterState가 all 이면 전부 return
    if (filterState == FilterState.all) {
      return shppingListState;
    }

    return shppingListState
        .where(
          // filterState가 spicy이면 item에 isSpicy가 true인 아이템만 리텀
          // 혹은 isSpicy가 false인 item을 리턴
          (e) => filterState == FilterState.spicy ? e.isSpicy : !e.isSpicy,
        )
        .toList();
  },
);

enum FilterState {
  // 안매움
  notSpicy,
  // 매움
  spicy,
  // 전부
  all
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
