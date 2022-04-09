// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:taptap/app/core/theme/color_theme.dart';

abstract class AppTextTheme {
  /// 보통 
  static const REGULAR = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColorTheme.MAINCOLOR);

  /// 큰
  static const MAIN = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: AppColorTheme.MAINCOLOR);
}
