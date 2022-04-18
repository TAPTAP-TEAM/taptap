import 'package:get/get.dart';
import 'package:taptap/app/modules/min/controller.dart';

class MinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MinPageController>(MinPageController());
  }
}
