import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class splashServices {

  void islogin(BuildContext context){

    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!= null) {
      SessionManager().userId = user.uid.toString();
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.dashboardScreen);
      });
    }else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RouteName.loginScreen);
      });
    }



  }


}