import 'package:actual2/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String path) {
    return 'http://$ip/$path';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}