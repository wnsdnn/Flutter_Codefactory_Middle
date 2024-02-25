import 'package:actual2/common/model/cursor_pagination_model.dart';
import 'package:actual2/common/model/model_with_id.dart';
import 'package:actual2/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
