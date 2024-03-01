import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';



class  LoginProvider with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  bool _loading = false;
  bool get loading=>_loading;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }


  void loginFtn(String email,String password,BuildContext context)async{
     setLoading(true);
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        SessionManager().userId = value.user!.uid.toString();
        Navigator.pushNamed(context,RouteName.dashboardScreen);
        generalUtills.toastMessage('Login Successful');
         setLoading(false);
        ref.child(value.user!.uid.toString()).set({
          'uid':value.user!.uid.toString(),
          'email':value.user!.email.toString(),
          'returnSecureToken':true,

        }).then((value){
          generalUtills.toastMessage('Data added ');
          setLoading(false);
        }).onError((error, stackTrace){
          generalUtills.toastMessage(error.toString());
          setLoading(false);
        });
      }).onError((error, stackTrace){
        generalUtills.toastMessage(error.toString());
        setLoading(false);
      });

    }catch(e){
      generalUtills.toastMessage(e.toString());
      setLoading(false);
    }


  }



}