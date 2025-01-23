import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/App_Resources/App_Icons.dart';

class custom_PasswordTextFromFiled extends StatefulWidget {
  TextEditingController controller;
  String hint;

  custom_PasswordTextFromFiled({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  State<custom_PasswordTextFromFiled> createState() => _custom_PasswordTextFromFiledState();
}

class _custom_PasswordTextFromFiledState extends State<custom_PasswordTextFromFiled> {

  bool _isvisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isvisible,
      controller: widget.controller,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.25),
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3), fontSize: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.1)
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.green.shade600,
              )),
          prefixIcon: AppIcon.lockIcon,
          suffixIcon: _isvisible ? IconButton(onPressed: (){
            setState(() {
              _isvisible = false;
            });
          }, icon: AppIcon.visibility_onIcon):IconButton(onPressed: (){
            setState(() {
              _isvisible = true;
            });
          }, icon: AppIcon.visibility_offIcon),
      ),
    );
  }
}
