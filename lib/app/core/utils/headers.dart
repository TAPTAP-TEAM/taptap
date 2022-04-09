import 'package:get/get.dart';

class HeadersAPI {
  Map<String, String>? getHeaders({bool auth = true}) {
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    return header;
  }
}
