import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:taptap/app/routes/pages.dart';
import 'package:taptap/app/routes/routes.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: Routes.INIT,
    getPages: AppPages.pages,
    theme: ThemeData(fontFamily: "Pretendard"),
  ));
}
