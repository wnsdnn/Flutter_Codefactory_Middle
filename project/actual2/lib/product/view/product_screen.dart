import 'package:actual2/product/component/pagination_list_view.dart';
import 'package:actual2/product/component/product_card.dart';
import 'package:actual2/product/model/product_model.dart';
import 'package:actual2/product/provider/product_provider.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return ProductCard.fromProductModel(
          model: model,
        );
      },
    );
  }
}
