import 'package:actual2/order/model/order_model.dart';
import 'package:actual2/order/model/post_order_body.dart';
import 'package:actual2/order/repository/order_repository.dart';
import 'package:actual2/user/model/basket_item_model.dart';
import 'package:actual2/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrderModel>>(
  (ref) {
    final repository = ref.watch(orderRepositoryProvider);

    return OrderStateNotifier(
      ref: ref,
      repository: repository,
    );
  },
);

class OrderStateNotifier extends StateNotifier<List<OrderModel>> {
  final Ref ref;
  final OrderRepository repository;

  OrderStateNotifier({
    required this.ref,
    required this.repository,
  }) : super([]);

  Future<bool> postOrder() async {
    try {
      final uuid = Uuid();
      final id = uuid.v4();

      final state = ref.read(basketProvider);

      final totalPrice = state.fold(0, (pv, e) => pv + e.count * e.product.price);

      final resp = await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state.map(
                (e) => PostOrderBodyProduct(
              productId: e.product.id,
              count: e.count,
            ),
          ).toList(),
          totalPrice: totalPrice,
          createdAt: DateTime.now().toString(),
        ),
      );

      return true;
    } catch(e) {
      return false;
    }
  }
}
