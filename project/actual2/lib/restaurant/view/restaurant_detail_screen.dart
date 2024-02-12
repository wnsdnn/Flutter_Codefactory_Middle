import 'package:actual2/common/layout/default_layout.dart';
import 'package:actual2/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '불타는 떡볶이',
            tags: ['떡볶이', '치즈', '매운맛'],
            ratingsCount: 100,
            deliveryTime: 15,
            deliveryFee: 2000,
            ratings: 4.55,
            isDetail: true,
            detail: '맛있는 떡볶이',
          ),
        ],
      ),
    );
  }
}
