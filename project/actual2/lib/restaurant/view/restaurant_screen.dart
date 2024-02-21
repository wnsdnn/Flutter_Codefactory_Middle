import 'package:actual2/common/const/data.dart';
import 'package:actual2/common/dio/dio.dart';
import 'package:actual2/common/model/cursor_pagination_model.dart';
import 'package:actual2/restaurant/component/restaurant_card.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/provider/restaurant_provider.dart';
import 'package:actual2/restaurant/repository/restaurant_repository.dart';
import 'package:actual2/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 여기선 datas가 List<RestaurantModel> 값임
    final datas = ref.watch(restaurantProvider);

    if(datas is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final pItems = datas as CursorPagination;

    // 비어있지 않으면 ListView에서 화면 렌더링
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: pItems.data.length,
        itemBuilder: (context, index) {
          final pItem = pItems.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailScreen(
                    id: pItem.id,
                    name: pItem.name,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(model: pItem),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 24.0);
        },
      ),
    );
  }
}
