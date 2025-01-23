import 'package:flutter/cupertino.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/App_Resources/App_Strings.dart';

class LS_commn_Ui extends StatelessWidget {
  const LS_commn_Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.appTitle,style: TextStyle(color: AppColor.primaryFontColor,fontWeight: FontWeight.w900,fontSize: 30,letterSpacing: 3),),
        Text(AppStrings.supportiveLine,style: TextStyle(color: AppColor.subFontColor,fontSize: 15),)
      ],
    );
  }
}
