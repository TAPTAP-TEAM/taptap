import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'package:taptap/app/data/models/user.dart';
import 'package:taptap/app/data/service/auth/service.dart';
import 'package:taptap/app/modules/home/controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomePageController controller = Get.find<HomePageController>();

  Widget _userName() {
    return controller.obx(
        (state) => Column(
              children: [
                Text(
                  controller.user.value!.user_name,
                  style: AppTextTheme.REGULAR,
                ),
                Text(controller.user.value!.user_seq_no,
                    style: AppTextTheme.REGULAR),
              ],
            ),
        onLoading: const Text("loading!..."));
  }

  Widget _account(Account account) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.account_alias,
                  style: AppTextTheme.MAIN,
                ),
                Text(account.account_num_masked)
              ],
            ),
          ),
          Text(account.bank_name)
        ]),
      ),
    );
  }

  Widget _accounts() {
    return controller.obx((state) {
      return SingleChildScrollView(
          child: Column(
              children: controller.user.value!.res_list
                  .map((e) => _account(e))
                  .toList()));
    }, onLoading: Container());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "홈화면",
                style: AppTextTheme.MAIN,
              ),
              _userName(),
              Flexible(child: _accounts()),
              ElevatedButton(
                  onPressed: () {
                    Get.find<AuthService>().logout();
                  },
                  child: const Text("로그아웃"))
            ],
          ),
        ),
      ),
    );
  }
}
