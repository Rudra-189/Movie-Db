import 'package:flutter/material.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/App_Resources/App_Icons.dart';
import 'package:movie/App_Resources/widget/Button_Ui.dart';
import 'package:movie/App_Resources/widget/Login_Singnup_common_ui.dart';
import 'package:movie/App_Resources/widget/Password_TextFromFiled_Ui.dart';
import 'package:movie/App_Resources/widget/TextFromFiled_Ui.dart';
import 'package:movie/demo.dart';

import 'Home Page.dart';
import 'SignUp Page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight *0.5,
                child: LS_commn_Ui(),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        custom_TextFromFiled(controller: emailController, hint: ' Email', prefixIcon: AppIcon.emailIcon,),
                        SizedBox(height: 15,),
                        custom_PasswordTextFromFiled(controller: passwordController, hint: ' Password',),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            GestureDetector(
                              child: Text(
                                'Forgot Your Password?',
                                style:
                                TextStyle(color: Colors.green.shade600, fontSize: 13,decoration: TextDecoration.underline,decorationColor: Colors.green.shade600),
                              ),
                              onTap: (){
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    InkWell(
                      child: custom_Button(name: "Login"),
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page(),));
                      },
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "you don't have an account? ",
                            style: TextStyle(color: AppColor.primaryFontColor),
                          ),
                          InkWell(
                            child: Text(
                              "Signup",
                              style: TextStyle(color: AppColor.subFontColor,decoration: TextDecoration.underline,decorationColor: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_Page(),));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
