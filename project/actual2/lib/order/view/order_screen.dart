import 'package:actual2/order/conponent/order_card.dart';
import 'package:actual2/order/model/order_model.dart';
import 'package:actual2/order/provider/order_provider.dart';
import 'package:actual2/product/component/pagination_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView(
      provider: orderProvider,
      itemBuilder: <OrderModel>(context, index, model) {
        return OrderCard.fromModel(
          model: model,
        );
      },
    );
  }
}
