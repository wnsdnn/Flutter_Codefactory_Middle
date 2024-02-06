import 'package:actual/common/component/pagination_list_view.dart';
import 'package:actual/order/component/order_card.dart';
import 'package:actual/order/model/order_model.dart';
import 'package:actual/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
      provider: orderProvider,
      itemBuilder: <OrderModel>(context, index, model) {
        return Text('왜 내가 하면 오류나냐?? 개새끼들아');
        // return OrderCard.fromModel(model: model);
      },
    );
  }
}
