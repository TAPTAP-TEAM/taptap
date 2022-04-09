import 'package:get/get.dart';
import 'package:taptap/app/data/models/authorize_param.dart';
part 'secret_key.dart';

class ApiProvider extends GetConnect {
  final String _baseUrl = "https://testapi.openbanking.or.kr";

  authorizeToken() async {
    final _parameter = AuthorizeParam.regular(CLINET_KEY);
    print("$_baseUrl/oauth/2.0/authorize${_parameter.stringify}");
    Response response =
        await get('$_baseUrl/oauth/2.0/authorize${_parameter.stringify}');
    print(response.body);
    print(response.statusCode);
  }
}
