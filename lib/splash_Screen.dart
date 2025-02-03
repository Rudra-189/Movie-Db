import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/routes/app_routes_name.dart';
import 'package:movie/widget/Login_Singnup_common_ui.dart';

class Splash_Page extends StatefulWidget {
  const Splash_Page({super.key});

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {

  GoogleSignIn googleSignIn = GoogleSignIn();
  
  @override
  void initState() {
    super.initState();
    checkSignIn();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: Center(
        child: LS_commn_Ui(),
      ),
    );
  }
  Future checkSignIn()async{

    Timer(Duration(seconds: 3),() async{
      bool user = await googleSignIn.isSignedIn();
      if(user){
        Navigator.pushReplacementNamed(context,AppRoutesName.homePage);
      }else{
        Navigator.pushReplacementNamed(context,AppRoutesName.loginPage);
      }
    },);
  }
}
