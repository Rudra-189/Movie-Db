import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/detail_Screen.dart';
import 'package:movie/home_Screen.dart';
import 'package:movie/login_Screen.dart';
import 'package:movie/profile_Screen.dart';
import 'package:movie/routes/app_routes_name.dart';
import 'package:movie/search_Screen.dart';
import 'package:movie/search_result_Screen.dart';
import 'package:movie/signup_Screen.dart';
import 'package:movie/splash_Screen.dart';

class AppRoutes{
  static Route<dynamic>? GenerateRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutesName.initialScreen:
        return MaterialPageRoute(builder: (context) => Splash_Page(),);
      case AppRoutesName.loginPage:
        return MaterialPageRoute(builder: (context) => Login_Page(),);
      case AppRoutesName.signupPage:
        return MaterialPageRoute(builder: (context) => Signup_Page(),);
      case AppRoutesName.homePage:
        return MaterialPageRoute(builder: (context) => Home_Page(),);
      case AppRoutesName.profilePage:
        return MaterialPageRoute(builder: (context) => ProfilePage(),);
      case AppRoutesName.searchPage:
        return MaterialPageRoute(builder: (context) => Search_Page(),);
      case AppRoutesName.detailPage: {
        final int Id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => Detail_Page(id: Id,),
        );
      }
      case AppRoutesName.searchResultPage:{
        final String name = settings.arguments.toString();
        return MaterialPageRoute(
          builder: (context) => Search_Result_Page(name: name),
        );
      }
      default : MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Center(child: Text("No Route will be define"),),
        );
      },);
    }
  }
}