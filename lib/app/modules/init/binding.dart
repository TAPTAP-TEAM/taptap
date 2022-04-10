import 'package:get/get.dart';
import 'package:taptap/app/modules/init/controller.dart';

class InitPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InitPageController>(InitPageController());
  }
}
