import 'package:flutter/cupertino.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/App_Resources/App_Strings.dart';
import 'package:movie/App_Resources/App_Styles.dart';

class LS_commn_Ui extends StatelessWidget {
  const LS_commn_Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.appTitle,style:AppStyles.header),
        Text(AppStrings.supportiveLine,style: AppStyles.subtitle,)
      ],
    );
  }
}
