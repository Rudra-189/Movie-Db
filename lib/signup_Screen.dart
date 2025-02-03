import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/App_Resources/App_Icons.dart';
import 'package:movie/routes/app_routes_name.dart';
import 'package:movie/widget/Button_Ui.dart';
import 'package:movie/widget/Login_Singnup_common_ui.dart';
import 'package:movie/widget/Password_TextFromFiled_Ui.dart';
import 'package:movie/widget/TextFromFiled_Ui.dart';

import 'home_Screen.dart';
import 'login_Screen.dart';

class Signup_Page extends StatefulWidget {
  const Signup_Page({super.key});

  @override
  State<Signup_Page> createState() => _Signup_PageState();
}

class _Signup_PageState extends State<Signup_Page> {

  GoogleSignIn googleSignIn = GoogleSignIn();

  final _formkey=GlobalKey<FormState>();

  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:  Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: LS_commn_Ui(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Form(
                  key: _formkey,
                  child:Container(
                    height: screenHeight * 0.50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        custom_TextFromFiled(controller: userController, hint: ' User', prefixIcon: AppIcon.personIcon,),
                        SizedBox(height: 15,),
                        custom_TextFromFiled(controller: emailController, hint: ' Email', prefixIcon: AppIcon.emailIcon,),
                        SizedBox(height: 15,),
                        custom_PasswordTextFromFiled(controller: passwordController, hint: ' Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'or',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Container(
                                  height: 60,
                                  width: screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/facebook.svg',
                                            height: 30,
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Facebook',
                                            style: TextStyle(color: Colors.white, fontSize: 17),
                                          ),
                                        ],
                                      )),
                                ),
                                onTap: (){
                                  SignIn();
                                },
                              ),
                              Expanded(child: SizedBox()),
                              InkWell(
                                child: Container(
                                  height: 60,
                                  width: screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/google.svg',
                                            height: 30,
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Google',
                                            style: TextStyle(color: Colors.white, fontSize: 17),
                                          ),
                                        ],
                                      )),
                                ),
                                onTap: (){

                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenHeight * 0.15,
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    InkWell(
                      child: custom_Button(name: "Create Account"),
                      onTap: () {
                        Navigator.pushNamed(context,AppRoutesName.homePage);
                      },
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color:AppColor.primaryFontColor),
                        ),
                        InkWell(
                          child:
                          Text('Login', style: TextStyle(color: AppColor.subFontColor,decoration: TextDecoration.underline,decorationColor: Colors.white)),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutesName.loginPage);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future SignIn()async{
    GoogleSignInAccount? user = await googleSignIn.signIn();
    if(user == null){
      print("User information : ${user}");
    }else{
      print("User information : ${user}");
      Navigator.pushReplacementNamed(context,'/home');
    }
  }
}
