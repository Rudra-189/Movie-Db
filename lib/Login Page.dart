import 'package:flutter/material.dart';

import 'Home Page.dart';
import 'SignUp Page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();


  final _formkey=GlobalKey<FormState>();

  bool _isvisible = false;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight *0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Movies',style: TextStyle(color: Colors.green.shade600,fontWeight: FontWeight.w900,fontSize: 30,letterSpacing: 3),),
                    Text('Stream Your Favorites Anytime',style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],
                ),
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
                        TextFormField(
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
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.1)
                              ),
                              borderRadius: BorderRadius.circular(15),
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
                        SizedBox(height: 15,),
                        TextFormField(
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
                              prefixIcon:
                              Icon(Icons.lock, color: Colors.green.shade600),
                              suffixIcon: _isvisible ? IconButton(icon: Icon(
                                Icons.visibility_off,
                                color: Colors.green.shade600.withOpacity(0.6),
                                size: 20,
                              ), onPressed: () {
                                setState(() {
                                  _isvisible = false;
                                });
                              },) : IconButton(icon: Icon(
                                Icons.visibility,
                                color: Colors.green.shade600.withOpacity(0.6),
                                size: 20,
                              ), onPressed: () {
                                setState(() {
                                  _isvisible = true;
                                });
                              },)
                          ),
                          validator: (value){
                          },
                        ),
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
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(17)),
                        child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
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
                            style: TextStyle(color: Colors.green.shade600),
                          ),
                          InkWell(
                            child: Text(
                              "Signup",
                              style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white),
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
