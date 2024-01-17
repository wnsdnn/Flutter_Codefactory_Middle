import 'package:actual/common/utils/data_utils.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    @JsonKey(
      fromJson: DataUtils.pathToUrl,
    )
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  // factory RestaurantDetailModel.fromJson({
  //   required Map<String, dynamic> json,
  //   bool isDetail = false,
  // }) {
  //   return RestaurantDetailModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip/${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //       (element) => element.name == json['priceRange'],
  //     ),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //     detail: json['detail'],
  //     products: json['products']
  //         .map<RestaurantProductModel>(
  //           (e) => RestaurantProductModel.fromJson(json: e),
  //         )
  //         .toList(),
  //   );
  // }
}

@JsonSerializable()
class RestaurantProductModel {
  // "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
  // "name": "마라맛 코팩 떡볶이",
  // "imgUrl": "/img/img.png",
  // "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
  // "price": 8000

  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    @JsonKey(
      fromJson: DataUtils.pathToUrl,
    )
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);

  // factory RestaurantProductModel.fromJson(
  //     {required Map<String, dynamic> json}) {
  //   return RestaurantProductModel(
  //     id: json['id'],
  //     name: json['name'],
  //     imgUrl: 'http://$ip/${json['imgUrl']}',
  //     detail: json['detail'],
  //     price: json['price'],
  //   );
  // }
}