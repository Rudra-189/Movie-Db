import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/App_Resources/App_Colors.dart';

class custom_TextFromFiled extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Icon prefixIcon;

  custom_TextFromFiled({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: AppColor.subFontColor),
      cursorColor: AppColor.subFontColor,
      decoration: InputDecoration(
        fillColor: AppColor.subFontColor.withOpacity(0.25),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
            color: AppColor.subFontColor.withOpacity(0.3), fontSize: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColor.subFontColor.withOpacity(0.1)
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.green.shade600,
            )),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
