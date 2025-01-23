import 'package:flutter/cupertino.dart';
import 'package:movie/App_Resources/App_Colors.dart';

class custom_Button extends StatelessWidget {
  String name;
  custom_Button({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(child: Text(name,style: TextStyle(color:AppColor.subFontColor,fontSize: 17),)),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(11)
      ),
    );
  }
}
