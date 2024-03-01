
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
class  ForgotPasswordProvider with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading=> _loading;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }



  void forgotPasswordFtn(BuildContext context,String email){
    setLoading(true);
    auth.sendPasswordResetEmail(email:email ).then((value){
      generalUtills.toastMessage('We have send you email,kindly check it out');
      setLoading(false);

    }).onError((error, stackTrace){
      generalUtills.toastMessage(error.toString());
      setLoading(false);
    });

  }



}
