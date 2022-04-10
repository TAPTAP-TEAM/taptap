import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'package:taptap/app/modules/init/controller.dart';

class InitPage extends GetView<InitPageController> {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "TAP TAP",
        style: AppTextTheme.MAIN,
      )),
    );
  }
}
