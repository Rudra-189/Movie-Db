import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/App_Resources/App_Colors.dart';
import 'package:movie/routes/app_routes_name.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  GoogleSignIn googleSignIn = GoogleSignIn();
  bool profile = false;
  late GoogleSignInAccount account;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: profile ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(account!.photoUrl.toString()),radius: 70,),
            Text(account!.displayName.toString(),style: TextStyle(color: AppColor.subFontColor),),
            Text(account!.email.toString(),style: TextStyle(color: AppColor.subFontColor),),
          ],
        ),
      ) : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(onPressed: (){
        googleSignIn.signOut().then((value) {
          Navigator.pushReplacementNamed(context,AppRoutesName.loginPage);
        },);
      }),
    );
  }
  void getprofile()async{
    await googleSignIn.signInSilently();
    account = (await googleSignIn.currentUser)!;
    print(account);
    setState(() {
      profile = true;
    });
  }
}
