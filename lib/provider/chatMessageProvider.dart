import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_media/services/seesionManager.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
import 'package:tech_media/view/Messages/chat_Screen.dart';


import 'package:flutter/material.dart';


class MessageProvider with ChangeNotifier {
  List<ChatScreen> _messages = [];
  Map<String, bool> _userOnlineStatus = {};// Map to store user online status

  List<ChatScreen> get messages => _messages;


  String? _username;

  String? get username => _username;

  // Method to set username
  setUsername(String username) {
    _username = username;
  }


  // Method to add a message
  void addMessage(ChatScreen message) {
    _messages.add(message);
    notifyListeners();
  }

  // Method to delete message
  Future<void>DeleteMessage(BuildContext context)async{
    return showDialog(context: context, builder:(BuildContext context){
       return AlertDialog(
         title: const Text('Delete'),
         content: Container(
           height: 50,
           width: 50,
           child:const  Text('Are you sure you want to delete'),
         ),
         actions: [
           TextButton(onPressed: (){
              Navigator.pop(context);
       }, child:const  Text('cancel',),
           ),
        TextButton(onPressed: (){
      FirebaseFirestore.instance.collection('messages').doc(SessionManager().userId.toString()).delete().then((value){
        generalUtills.toastMessage('Message Deleted');
        Navigator.pop(context);

      }).onError((error, stackTrace){
        generalUtills.toastMessage(error.toString());
      });
      }, child:const  Text("Delete",style: TextStyle(color: Colors.red),))
         ],
       );

    });


        }

    // Method to fetch messages and update user online status
    void fetchMessages() async {
      try {
        final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('messages').get();

        _messages = querySnapshot.docs
            .map(
              (doc) =>
              ChatScreen(
                text: doc['text'],
                sender: doc['sender'],
                image: doc['Profile'],
                receiver: doc['Receiver'],
              ),
        )
            .toList();

        // Update user online status for each sender
        for (var message in _messages) {
          updateUserOnlineStatus(message.sender);
        }

        notifyListeners();
      } catch (error) {
        debugPrint("Error fetching messages: $error");
      }
    }


    updateUserOnlineStatus(String username) async {
      bool isOnline = _userOnlineStatus.containsKey(username)
          ? !_userOnlineStatus[username]!
          : true;
      _userOnlineStatus[username] = isOnline;
    }

    bool getUserOnlineStatus(String username) {
      return _userOnlineStatus[username] ?? false;
    }


  }