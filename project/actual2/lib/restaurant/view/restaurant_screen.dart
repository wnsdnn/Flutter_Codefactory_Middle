import 'package:actual2/common/const/data.dart';
import 'package:actual2/restaurant/component/restaurant_card.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                final pItem = RestaurantModel.fromJson(item); // parsed

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
                return SizedBox(height: 24.0);
              },
            );
          },
        ),
      ),
    );
  }
}
