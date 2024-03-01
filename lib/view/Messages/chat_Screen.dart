import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/provider/chatMessageProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatScreen extends StatefulWidget {
  final String text,sender,receiver;
  final dynamic image;

  const ChatScreen({super.key,required this.text,required this.image,required this.sender,required this.receiver,});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final MessageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    title:Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align rows to the start (left)
      children: [
        Padding(
          padding:const  EdgeInsets.only(top: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image), // Make sure to provide image
              ),
              const SizedBox(width: 20),
              Text(widget.text), // Use the username here
            ],
          ),
        ),
        Padding(
          padding:const  EdgeInsets.only(left: 60,),
          child: Row(
            children: [
              Consumer<MessageProvider>(
                builder: (context, messageProvider, _) {
                  final isUserOnline = messageProvider.getUserOnlineStatus(widget.text);
                  return Text(
                    isUserOnline ? 'offline' : 'online',
                    style: TextStyle(color: isUserOnline ? Colors.black : Colors.black,fontSize: 13),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
      ),






      body: SafeArea(
        child: Column(
          children: [
           Expanded(child: Consumer<MessageProvider>(
             builder: (context, messageProvider, _) {
               return  ListView.builder(
                   itemCount: messageProvider.messages.length,
                   itemBuilder: (context, index) {
                     final ChatScreen message = messageProvider.messages[index];
                     return InkWell(
                       onTap: (){

                         setState(() {
                           messageProvider.DeleteMessage(context);
                         });
                       },
                       child: ListTile(
                         title: Text(message.text),
                         subtitle: Text(message.sender),
                         // Optionally, display image if available
                         leading: message.image,
                             ),
                     );
                   },
                 );

             },
           ), ),
              Consumer<MessageProvider>(builder:(context,MessageProvider,_){
                return   Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding:const  EdgeInsets.only(left: 10,right: 10,bottom: 20),
                          child: TextFormField(
                            controller: MessageController,
                            decoration: InputDecoration(
                              hintText: 'Send message',
                              suffixIcon: IconButton(
                                      iconSize: 30,
                                      icon: const Icon(Icons.send),
                                      onPressed: () {
                       final String text = MessageController.text.trim();
                          if (text.isNotEmpty) {
                          final  message = ChatScreen(text: text, sender:'user',image:null,receiver: 'User2',);
                          MessageProvider.addMessage(message);
                          MessageController.clear();
                          FirebaseFirestore.instance.collection('messages').add({
                          'text': message.text,
                          'sender': message.sender,
                          'timestamp': FieldValue.serverTimestamp(),
                          'Profile':message.image
                          });
                          }
                      
                          },
                          ),
                      
                      
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                                      )
                                      ),
                    ),
                  ]
                );

              }),


    ],
                     ),
    ),
    );

  }
}




