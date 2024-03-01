import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';

class ImagePickerNotifier with ChangeNotifier {

  final databaseref = FirebaseDatabase.instance.ref('user');
  final  FirebaseStorage   Storage = FirebaseStorage.instance;

 final UpdateController = TextEditingController();
 final UpdateEmailController = TextEditingController();

  bool _loading = false;
  bool get loading=> _loading;

  setLoading(bool value){
    _loading =value;
    notifyListeners();
  }

  File? _image;
  final picker = ImagePicker();

  File? get image => _image;

  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage();
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

 Future<void> uploadImage()async{
    setLoading(true);
   Reference ref = Storage.ref().child('/ProfilePicture/${SessionManager().userId.toString()}');

   try {
     UploadTask uploadTask = ref.putFile(_image!);

     TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

     String downloadUrl = await snapshot.ref.getDownloadURL();

     await databaseref.child('Profile').set(downloadUrl);
     if (kDebugMode) {
       print('Image uploaded successfully.');
     }
     setLoading(false);
   } catch (error) {
     if (kDebugMode) {
       print('Error uploading image: $error');
     }
     setLoading(false);
   }


 }

 Future<void> showUpdateUsername(BuildContext context,String name)async{
    UpdateController.text = name;
   await showDialog(context: context, builder: (context){
      return AlertDialog(
         title:const  Text('update Your UserName'),
        content: Container(
          child: TextFormField(
            controller: UpdateController,
            decoration:const InputDecoration(
              hintText: 'Edit'
            ),

          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const Text('cancel',style: TextStyle(color: AppColors.alertColor),),),
          TextButton(onPressed: (){
            setLoading(true);
             databaseref.child(SessionManager().userId.toString()).update({
               'username':UpdateController.text.toString(),
             }).then((value){
               Navigator.pop(context);
               generalUtills.toastMessage('Username added');
               setLoading(false);
             }).onError((error, stackTrace){
               generalUtills.toastMessage(error.toString());
               setLoading(false);
             });
          }, child:const Text('ok'))
        ],
      );

    });


 }

  Future<void> showUpdateEmail(BuildContext context,String email)async{
    UpdateEmailController.text = email;
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title:const  Text('update Your email'),
        content: Container(
          child: TextFormField(
            controller: UpdateEmailController,
            decoration:const InputDecoration(
                hintText: 'Edit'
            ),

          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const Text('cancel',style: TextStyle(color: AppColors.alertColor),),),
          TextButton(onPressed: (){
            setLoading(true);
            databaseref.child(SessionManager().userId.toString()).update({
              'email':UpdateEmailController.text.toString(),
            }).then((value){
              Navigator.pop(context);
              generalUtills.toastMessage('email Added');
              setLoading(false);
            }).onError((error, stackTrace){
              generalUtills.toastMessage(error.toString());
              setLoading(false);
            });
          }, child:const Text('ok'))
        ],
      );

    });


  }


}