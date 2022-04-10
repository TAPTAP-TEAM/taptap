import 'package:get/get.dart';
import 'package:taptap/app/modules/home/controller.dart';
import 'package:taptap/app/modules/home/repository.dart';
import 'package:taptap/app/data/provider/api.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(
        HomePageController(UserRepository(ApiProvider())));
  }
}
