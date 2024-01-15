import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // baseUrl - http://$ip/restaurant/
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // baseUrl - http://$ip/restaurant/
  // @GET('/')
  // paginate();

  // baseUrl - http://$ip/restaurant/:id
  @GET('/{id}')
  // 임시로 넣은 토큰값
  @Headers({
    'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzA1MzI5MjEzLCJleHAiOjE3MDUzMjk1MTN9.TH3rNAqT9__EaeK7ArpZV0B5pHWSc3QMnEC0NBokotY'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
