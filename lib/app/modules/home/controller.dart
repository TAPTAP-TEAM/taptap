import 'package:get/get.dart';
import 'package:taptap/app/data/models/user.dart';
import 'package:taptap/app/modules/home/repository.dart';

class HomePageController extends GetxController with StateMixin {
  final UserRepository repository;
  HomePageController(this.repository);

  Rx<UserInfo?> user = Rx(null);

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  Future _loadData() async {
    change(null, status: RxStatus.loading());
    user.value = await repository.getUserInfo();
    change(null, status: RxStatus.success());
  }
}
