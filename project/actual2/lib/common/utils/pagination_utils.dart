import 'package:actual2/common/provider/pagination_provider.dart';
import 'package:flutter/cupertino.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    final isScrollLast =
        controller.offset > controller.position.maxScrollExtent - 300;

    if (isScrollLast) {
      provider.paginate(
            fetchMore: isScrollLast,
          );
    }
  }
}
