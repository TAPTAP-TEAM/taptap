import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'package:taptap/app/data/service/auth/service.dart';
import 'package:taptap/app/modules/login/controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final controller = Get.find<LoginPageController>();
  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "오픈뱅킹 로그인하기",
                style: AppTextTheme.REGULAR,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  child: const Text("로그인")),
            ],
          ),
        ),
      ),
    );
  }
}
