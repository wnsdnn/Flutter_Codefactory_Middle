import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    print(id);

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('에러가 발생하였습니다'),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final item = RestaurantDetailModel.fromJson(
              json: snapshot.data!,
            );

            return CustomScrollView(
              slivers: [
                renderTop(
                  model: item,
                ),
                renderLabel(),
                renderProducts(),
              ],
            );
          }),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(),
            );
          },
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
