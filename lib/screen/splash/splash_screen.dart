import 'package:dizisalon_vender/screen/auth/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:3),(){
      viewScreen();
    });

  }
  Future viewScreen()async{
    final prefs = await SharedPreferences.getInstance();
        var  userId = await prefs.getString(
            'userId');
            if (userId !=null && userId !="") {
              print(userId);
              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),result: (route)=>false
                              );
            } else {
              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),result: (route)=>false
                              );
            }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Image.asset("assets/image/app_icon.png",height: 150,width: 150,),
      ),
    );
  }
}