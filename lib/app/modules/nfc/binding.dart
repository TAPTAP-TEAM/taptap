import 'package:get/get.dart';
import 'package:taptap/app/modules/nfc/controller.dart';

class NfcPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NfcPageController>(NfcPageController());
  }
}
