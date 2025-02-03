import 'package:movie/App_Resources/App_Colors.dart';
import 'package:flutter/material.dart';

abstract class AppStyles{
  static TextStyle? header = TextStyle(
    color: AppColor.primaryFontColor,
    fontSize: 30,
    fontWeight: FontWeight.w900,
    letterSpacing: 3,
  );
  static TextStyle? title = TextStyle(
    color: AppColor.primaryFontColor,
    fontSize: 16,
    fontWeight: FontWeight.w500
  );
  static TextStyle? subtitle = TextStyle(
      color: AppColor.subFontColor,
      fontSize: 14,
      fontWeight: FontWeight.w500
  );
}