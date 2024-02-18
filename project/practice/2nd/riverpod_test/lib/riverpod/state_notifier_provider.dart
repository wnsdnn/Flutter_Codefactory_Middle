import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/shopping_item_model.dart';

// StateNotifierProvider에는 재너릭을 꼭 써야하는데
// <사용할 클래스, 해당클래스가 리턴하는 타입> 이렇게 2가지는 꼭 써줘야함
final shoppingListProvider =
    StateNotifierProvider<ShppingListNotifier, List<ShoppingItemModel>>(
  (ref) => ShppingListNotifier(),
);

// StateNotifierProvider - 해당 클래스를 Provider로 만들어서 관리하는 것
// StateNotifier - StateNotifierProvider안에 제공이 될 클래스가 상속하는 것
class ShppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  // super안에 처음에 어떤 상태로 값을 초기화할지 지정해줘야함
  ShppingListNotifier()
      : super(
          [
            ShoppingItemModel(
              name: '김치',
              quantity: 3,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: '라면',
              quantity: 5,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: '삼겹살',
              quantity: 10,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: '수박',
              quantity: 2,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: '카스테라',
              quantity: 5,
              hasBought: false,
              isSpicy: false,
            ),
          ],
        );

  void toggleHasBought({
    required String name,
  }) {
    // state(클래스에서 자동으로 제공됨)
    // ref.read([provider]).state와 같음
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy,
              )
            : e)
        .toList();
  }
}
