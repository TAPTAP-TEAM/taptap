import 'package:get/get.dart';
import 'package:taptap/app/data/models/authorize_param.dart';
import 'package:taptap/app/data/models/issue_token.dart';
import 'package:taptap/app/data/service/auth/service.dart';
import 'package:taptap/app/routes/routes.dart';

class LoginPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  late AuthorizeResponse authResponse;
  late IssueTokenResponse issueTokenResponse;

  Future<void> login() async {
    await authService.login();
    print("TOKEN2 :${authService.token}  ");
    if (authService.token != "") Get.offNamed(Routes.HOME);
  }
}
