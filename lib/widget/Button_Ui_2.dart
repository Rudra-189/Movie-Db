import 'package:flutter/cupertino.dart';
import 'package:movie/App_Resources/App_Colors.dart';

class custom_Button_2 extends StatelessWidget {
  String name;
  custom_Button_2({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(child: Text(name,style: TextStyle(color:AppColor.subFontColor,fontSize: 16),)),
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(11)
      ),
    );
  }
}
