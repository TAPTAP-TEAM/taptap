import 'package:get/get.dart';

class HeadersAPI {
  Map<String, String>? getHeaders({bool auth = false, String? token}) {
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded"
    };

    if (auth == true) {
      header = {"Authorization": "Bearer $token"};
    }

    return header;
  }
}
