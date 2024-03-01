import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/provider/profilepicture.provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/ReusbaleRow2.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseDatabase.instance.ref('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const  EdgeInsets.only(bottom: 10,top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:const  EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 350,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder(
                          stream: ref.child(SessionManager().userId.toString()).onValue,
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
                                          Center(child: ReusableRowTwo(title: 'Welcome', value: map['username']+'!')),
                                        const   Padding(
                                                padding:EdgeInsets.symmetric(),
                                             child: Text('Es un hecho establecido hace.',style: TextStyle(color: Colors.grey),)),

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
                              generalUtills.toastMessage('Added');
                              return Container(); // Return a fallback widget
                            }
                          },
                        ),
                      ]
                ),
              ),
            ),

      ],
    ),
    ),
    );
  }
}


