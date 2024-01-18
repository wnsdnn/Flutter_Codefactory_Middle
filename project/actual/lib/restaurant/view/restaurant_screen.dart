import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScrenn extends ConsumerWidget {
  const RestaurantScrenn({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    // final dio = Dio();
    //
    // dio.interceptors.add(
    //   CustomInterceptor(storage: storage),
    // );

    final response =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant/').paginate();

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    //
    // final response = await dio.get(
    //   'http://$ip/restaurant',
    //   options: Options(headers: {
    //     'authorization': 'Bearer $accessToken',
    //   }),
    // );

    return response.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(ref),
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
                  final pItem = response[index]!;
                  // parsed item
                  // final pItem = RestaurantModel.fromJson(item);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return RestaurantDetailScreen(
                              id: pItem.id,
                            );
                          },
                        ),
                      );
                    },
                    child: RestaurantCard.fromModel(
                      model: pItem,
                    ),
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
