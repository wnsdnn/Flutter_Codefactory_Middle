import 'dart:convert';

import 'package:actual2/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String path) {
    return 'http://$ip/$path';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain) {
    // base64 형식으로 String 값을 바꿔주는 방법
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain);

    return encoded;
  }
}