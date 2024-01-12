import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScrenn extends StatelessWidget {
  const RestaurantScrenn({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );

    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("에러가 발생하였습니다."),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final response = snapshot.data!;

              return ListView.separated(
                itemBuilder: (context, index) {
                  final item = response[index]!;
                  // parsed
                  print(item['priceRange']);
                  final pItem = RestaurantModel(
                    id: item['id'],
                    name: item['name'],
                    thumbUrl: 'http://$ip/${item['thumbUrl']}',
                    tags: List<String>.from(item['tags']),
                    priceRange: RestaurantPriceRange.values.firstWhere(
                      (element) => element.name == item['priceRange'],
                    ),
                    ratings: item['ratings'],
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                  );

                  return RestaurantCard(
                    image: Image.network(
                      pItem.thumbUrl,
                      fit: BoxFit.cover,
                    ),
                    name: pItem.name,
                    tags: pItem.tags,
                    ratingsCount: pItem.ratingsCount,
                    deliveryTime: pItem.deliveryTime,
                    deliveryFee: pItem.deliveryFee,
                    ratings: pItem.ratings,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 32.0);
                },
                itemCount: response.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
