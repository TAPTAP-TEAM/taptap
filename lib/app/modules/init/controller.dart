import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:taptap/app/data/service/auth/service.dart';
import 'package:taptap/app/routes/routes.dart';

class InitPageController extends GetxController {
  @override
  void onInit() {
    initializeApp();
    super.onInit();
  }

  initializeApp() async {
    Get.put<FlutterSecureStorage>(const FlutterSecureStorage(),
        permanent: true);
    await Get.putAsync(() => AuthService().init());
    AuthService authService = Get.find<AuthService>();
    if (authService.token != "") {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
