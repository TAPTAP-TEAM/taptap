import 'package:get/get.dart';
import 'package:taptap/app/modules/login/controller.dart';

class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginPageController>(LoginPageController());
  }
}
