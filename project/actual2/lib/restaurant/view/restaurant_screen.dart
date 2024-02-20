import 'package:actual2/common/const/data.dart';
import 'package:actual2/common/dio/dio.dart';
import 'package:actual2/restaurant/component/restaurant_card.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/repository/restaurant_repository.dart';
import 'package:actual2/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);
    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant/')
            .paginate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
          future: paginateRestaurant(ref),
          builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
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
                final pItem = snapshot.data![index];

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
