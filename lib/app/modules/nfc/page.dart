import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'package:taptap/app/modules/nfc/controller.dart';

class NfcPage extends StatelessWidget {
  NfcPage({Key? key}) : super(key: key);

  NfcPageController controller = Get.find<NfcPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "NFC 테스트",
            style: AppTextTheme.MAIN,
          ),
          ElevatedButton(
              onPressed: () {
                controller.startSession(
                    context: context, handleTag: controller.readHandleTag);
              },
              child: const Text("읽기")),
          ElevatedButton(
              onPressed: () {
                controller.startSession(
                    context: context, handleTag: controller.writeHandleTag);
              },
              child: const Text("쓰기"))
        ],
      )),
    );
  }
}
