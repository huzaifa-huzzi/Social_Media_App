import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/provider/profilepicture.provider.dart';
import 'package:tech_media/res/ReusableRow.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/RoundButton.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class ProflieScreen extends StatefulWidget {
  const ProflieScreen({super.key});

  @override
  State<ProflieScreen> createState() => _ProflieScreenState();
}

class _ProflieScreenState extends State<ProflieScreen> {

  final databaseref = FirebaseDatabase.instance.ref('user');
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:const EdgeInsets.only(bottom: 100),
              child: StreamBuilder(
                stream: databaseref.child(SessionManager().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) { // Add '?' to DataSnapshot to make it nullable
                  if (!snapshot.hasData || snapshot.data == null) { // Check if snapshot has data and if the data is not null
                    // Loading state: Display a CircularProgressIndicator
                    return const Center(child: CircularProgressIndicator(color: Colors.black));
                  } else if (snapshot.hasData) {
                    // Data available: Display user profile information
                    Map<dynamic, dynamic>? map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                    if (map != null) {
                      // Process and display user profile information
                      return Consumer<ImagePickerNotifier>(
                          builder: (context, imagePicker, _) {
                            return Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                          onTap: () => imagePicker.getGalleryImage(),
                                          child: Column(
                                            children: [
                                              Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 80,
                                                    backgroundColor: Colors.grey[200],
                                                    backgroundImage: imagePicker.image != null
                                                        ? FileImage(imagePicker.image!)
                                                        : null, // Display the picked image if available
                                                    child: imagePicker.image == null
                                                        ? Icon(
                                                      Icons.camera_alt,
                                                      size: 50,
                                                      color: Colors.grey[800],
                                                    )
                                                        : null,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(top: 4),
                                                    child: CircleAvatar(
                                                      backgroundColor: AppColors.primaryIconColor,
                                                      child: Icon(Icons.add,color: Colors.white,),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 120,),
                                GestureDetector(
                                    onTap:(){
                                      imagePicker.showUpdateUsername(context, map['username']);
                                    },
                                    child: ReusableRow(title: 'username', value: map['username'],iconData: Icons.person)
                                ),
                                const SizedBox(height: 40,),
                                GestureDetector(
                                  onTap:(){
                                    imagePicker.showUpdateEmail(context, map['email']);
                            },
                                    child: ReusableRow(title: 'email', value: map['email'],iconData: Icons.email_outlined)),
                              ],
                            );
                          }
                      );
                    } else {
                      // Handle null data
                      return const Text('Data not available');
                    }
                  } else {
                    // Error state: Display an error message
                    generalUtills.toastMessage('Something went wrong');
                    return Container(); // Return a fallback widget
                  }
                },
              )

            ),
            Consumer<ImagePickerNotifier>(builder: (context, imagePicker, _){
              imagePicker.setLoading(true);
              return Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: RoundButton(title: 'Logout',loading: loading ,ontap: (){
                  auth.signOut().then((value){
                    SessionManager().userId ='';
                    Navigator.pushNamed(context, RouteName.loginScreen);
                  }).then((value){
                    generalUtills.toastMessage('Logout');
                    imagePicker.setLoading(false);
                  }).onError((error, stackTrace){
                    generalUtills.toastMessage(error.toString());
                    imagePicker.setLoading(false);
                  });
                },
                ),
              );
            }),
]
        ),
    ),
      );



  }
}











