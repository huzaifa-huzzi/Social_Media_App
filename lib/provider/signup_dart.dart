import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
import 'package:tech_media/utils/routes/route_name.dart';


class signinProvider with ChangeNotifier{


  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }


  void SignUpftn(BuildContext context,String username,String email,String password)async{
    setLoading(true);
   try{
     auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
       SessionManager().userId = value.user!.uid.toString();
       generalUtills.toastMessage('Sign in Succesful');
       Navigator.pushNamed(context,RouteName.dashboardScreen);
        ref.child(value.user!.uid.toString()).set({
           'username':username,
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