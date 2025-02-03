import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/App_Resources/App_Colors.dart';

abstract class AppIcon{
  static final emailIcon = Icon(Icons.alternate_email,color: AppColor.primaryColor);
  static final personIcon = Icon(Icons.person, color: AppColor.primaryColor);
  static final lockIcon = Icon(Icons.lock, color: AppColor.primaryColor);
  static final visibility_onIcon = Icon(Icons.visibility, color: AppColor.primaryColor, size: 20,);
  static final visibility_offIcon = Icon(Icons.visibility_off, color: AppColor.primaryColor, size: 20,);
  static final menuIcon = Icon(Icons.menu, color: AppColor.primaryColor, size: 20,);
}