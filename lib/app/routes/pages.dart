import 'package:get/get.dart';
import 'package:taptap/app/modules/home/binding.dart';
import 'package:taptap/app/modules/home/page.dart';
import 'package:taptap/app/modules/init/binding.dart';
import 'package:taptap/app/modules/login/binding.dart';
import 'package:taptap/app/modules/login/page.dart';
import 'package:taptap/app/modules/min/binding.dart';
import 'package:taptap/app/modules/min/page.dart';
import 'package:taptap/app/routes/routes.dart';
import 'package:taptap/app/modules/init/page.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INIT,
        page: () => const InitPage(),
        binding: InitPageBinding()),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        binding: LoginPageBinding()),
    GetPage(
        name: Routes.HOME, page: () => HomePage(), binding: HomePageBinding()),
    GetPage(name: Routes.MIN, page: () => MinPage(), binding: MinPageBinding()),
  ];
}
