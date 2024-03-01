import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/view/Messages/chat_Screen.dart';


class MessagesScreen extends StatefulWidget {

 const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const  Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                } else {
                  Map<dynamic, dynamic>? map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                  if (map == null) {
                    return const  Center(
                      child: Text('No data available'),
                    );
                  }

                  List<dynamic> list = map.values.toList();

                  return ListView.builder(
                    itemCount:list.length,
                    itemBuilder: (context, index) {
                      // Get the item at the current index
                      var item = list[index];

                      // Handle cases where item is not a map
                      if (item is! Map) {
                        return const ListTile(
                          title: Text('No More People'),
                        );
                      }
                      // Convert the item to a map
                      Map<String, dynamic> mapItem = item.cast<String, dynamic>();

                      // Define a default image provider (Icon) in case 'Profile' is null or empty
                      ImageProvider<Object>? backgroundImage;
                      if (mapItem['Profile'] != null && mapItem['Profile'] != '') {
                        // Use Image.network if 'Profile' is a valid URL
                        backgroundImage = NetworkImage(mapItem['Profile']);
                      }

                      return InkWell(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ChatScreen(text: mapItem['username'].toString(), image: mapItem['Profile'].toString(),sender: DateTime.now().toString(),receiver: 'Me',),
                            withNavBar: false,
                          );

                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: backgroundImage, // Use default if backgroundImage is null
                          ),
                          title: Text(mapItem['username'] ?? 'No Username'),
                          subtitle: Text(mapItem['email'] ?? 'No Email'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
    ]
             ),
    );
  }
}
