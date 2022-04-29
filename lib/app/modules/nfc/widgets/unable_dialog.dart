import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/core/theme/text_theme.dart';

class UnAbleDialog extends StatelessWidget {
  const UnAbleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: const [
          Text(
            "NFC가 켜져 있지 않습니다",
            style: AppTextTheme.MAIN,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "NFC가 켜져 있는지 혹은 NFC를 지원하는 기기인지 확인해주세요",
            style: AppTextTheme.REGULAR,
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("확인"))
      ],
    );
  }
}
