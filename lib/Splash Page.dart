import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/Login%20Page.dart';

class Splash_Page extends StatefulWidget {
  const Splash_Page({super.key});

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page(),)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Movies',style: TextStyle(color: Colors.green.shade600,fontWeight: FontWeight.w900,fontSize: 30,letterSpacing: 3),),
            Text('Stream Your Favorites Anytime',style: TextStyle(color: Colors.white,fontSize: 15),)
          ],
        ),
      ),
    );
  }
}
