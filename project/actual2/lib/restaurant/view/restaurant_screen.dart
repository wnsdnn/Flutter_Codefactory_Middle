import 'package:actual2/common/const/data.dart';
import 'package:actual2/common/dio/dio.dart';
import 'package:actual2/common/model/cursor_pagination_model.dart';
import 'package:actual2/common/utils/pagination_utils.dart';
import 'package:actual2/restaurant/component/restaurant_card.dart';
import 'package:actual2/restaurant/model/restaurant_model.dart';
import 'package:actual2/restaurant/provider/restaurant_provider.dart';
import 'package:actual2/restaurant/repository/restaurant_repository.dart';
import 'package:actual2/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantProvider.notifier),
    );

    // 현재 위치가 최대 길이보다
    // 조금 덜되는 위치까지 왔다면
    // 새로운 데이터를 추가요청
    // final isScrollLast =
    //     controller.offset > controller.position.maxScrollExtent - 300;
    //
    // if (isScrollLast) {
    //   ref.read(restaurantProvider.notifier).paginate(
    //         fetchMore: isScrollLast,
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    // 여기선 datas가 List<RestaurantModel> 값임
    final datas = ref.watch(restaurantProvider);

    // 완전 처음 로딩일때
    if (datas is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (datas is CursorPaginationError) {
      return Center(
        child: Text(datas.message),
      );
    }

    // CursorPagination
    // CursorPagiantionFetchingMore
    // CursorPagiantionRefetching

    final pItems = datas as CursorPagination;

    // 비어있지 않으면 ListView에서 화면 렌더링
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: pItems.data.length + 1,
        itemBuilder: (context, index) {
          if (index == pItems.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                child: pItems is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터입니다 ㅠㅠ'),
              ),
            );
          }

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
