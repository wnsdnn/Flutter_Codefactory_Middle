import 'package:actual/common/provider/pagination_provider.dart';
import 'package:flutter/cupertino.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider
}) {
    if (controller.offset > controller.position.maxScrollExtent - 200) {
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}