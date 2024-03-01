
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class generalUtills{

  static focusftn(BuildContext context ,FocusNode current,FocusNode next){

    current.unfocus();
    FocusScope.of(context).requestFocus(next);

  }

  static toastMessage(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondaryTextColor,
        textColor: AppColors.primaryTextTextColor,
        fontSize: 16.0
    );

  }


}