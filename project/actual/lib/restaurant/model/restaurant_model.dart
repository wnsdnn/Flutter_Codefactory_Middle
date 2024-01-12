import 'package:actual/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // 일반 생성자랑 다를게 없지만 현재 클래스를 상속한 클래스도 만들수 있음(return)
  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip/${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
            (element) => element.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
    );
  }
}
