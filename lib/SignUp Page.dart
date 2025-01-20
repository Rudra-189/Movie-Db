import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Home Page.dart';
import 'Login Page.dart';

class Signup_Page extends StatefulWidget {
  const Signup_Page({super.key});

  @override
  State<Signup_Page> createState() => _Signup_PageState();
}

class _Signup_PageState extends State<Signup_Page> {

  final _formkey=GlobalKey<FormState>();

  final TextEditingController usercontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool _isvisible = false;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:  Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Movies',style: TextStyle(color: Colors.green.shade600,fontWeight: FontWeight.w900,fontSize: 30,letterSpacing: 3),),
                    Text('Stream Your Favorites Anytime',style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],
                ),
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
                        Container(
                          child: TextFormField(
                            controller: usercontroller,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.25),
                              filled: true,
                              hintText: ' User',
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
                              prefixIcon:
                              Icon(Icons.person, color: Colors.green.shade600),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            controller: emailcontroller,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.25),
                              filled: true,
                              hintText: ' Email',
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
                              prefixIcon: Icon(Icons.alternate_email,
                                  color: Colors.green.shade600),
                            ),

                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          child: TextFormField(
                            obscureText: _isvisible,
                            controller: passwordcontroller,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.25),
                                filled: true,
                                hintText: ' Password',
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
                                prefixIcon: Icon(Icons.lock, color: Colors.green.shade600),
                                suffixIcon: _isvisible ? IconButton(icon:  Icon(
                                  Icons.visibility_off,
                                  color: Colors.green.shade600.withOpacity(
                                    0.6,
                                  ),
                                  size: 20,
                                ), onPressed: () {
                                  setState(() {
                                    _isvisible = false;
                                  });
                                },) : IconButton(icon:  Icon(
                                  Icons.visibility,
                                  color: Colors.green.shade600.withOpacity(
                                    0.6,
                                  ),
                                  size: 20,
                                ), onPressed: () {
                                  setState(() {
                                    _isvisible =true;
                                  });
                                },)
                            ),

                          ),
                        ),
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
                              Container(
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
                                          'assets/images/facebook-3 1.svg',
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
                              Expanded(child: SizedBox()),
                              Container(
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
                                          'assets/images/google-icon 1.svg',
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
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(17)),
                        child: Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page(),));
                      },
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.green.shade600),
                        ),
                        InkWell(
                          child:
                          Text('Login', style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Page(),));
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
}
