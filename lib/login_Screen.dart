import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  GoogleSignIn googleSignIn = GoogleSignIn();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final _formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight *0.4,
                child: LS_commn_Ui(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  //color: Colors.white,
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
                        ),
                        SizedBox(height: 20,),
                        Row(
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
                                FacebookSignIn();
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
                                SignIn();
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      InkWell(
                        child: custom_Button(name: "Login"),
                        onTap: () async {
                          Navigator.pushNamed(context,AppRoutesName.homePage);
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
                                Navigator.pushNamed(context,AppRoutesName.signupPage);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:(){
      //   },
      // ),
    );
  }
  Future SignIn()async{
    GoogleSignInAccount? user = await googleSignIn.signIn();
    if(user == null){
      print("User information : ${user}");
    }else{
      print("User information : ${user}");
      Navigator.pushReplacementNamed(context,AppRoutesName.homePage);
    }
  }

  Future FacebookSignIn()async{
    FacebookAuth.instance.login(
      permissions: ["profile","email"]).then((value) {
        FacebookAuth.instance.getUserData().then((value) {
          print("/////User Data : "+value.toString());
        },);
      },);
  }
}
