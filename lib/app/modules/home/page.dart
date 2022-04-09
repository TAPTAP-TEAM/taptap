import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/data/service/auth/service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("홈화면입니다!"),
            ElevatedButton(
                onPressed: () {
                  Get.find<AuthService>().logout();
                },
                child: Text("로그아숭"))
          ],
        ),
      ),
    );
  }
}
