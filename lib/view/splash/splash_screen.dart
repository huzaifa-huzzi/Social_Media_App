import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/services/splashservices.dart';
import 'package:tech_media/utils/routes/route_name.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  splashServices  splashScreen = splashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Image(image: AssetImage('assets/images/logo.jpg')),
               Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text('Tech Brothers Media' , style: TextStyle(fontFamily: AppFonts.sfProDisplayBold , fontSize: 40, fontWeight: FontWeight.w700),)),
              )
            ],
          )
      ),
    );
  }
}
