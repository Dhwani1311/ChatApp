import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/UI/msg.dart';
import 'package:flutter_firebase/model/message.dart';
import '../mydata.dart';

class ChatScreen extends StatefulWidget {
  final String idUser;

  ChatScreen({this.idUser});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ChatScreen> {
  String groupchatId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseApi.getGroupId(groupchatId, widget.idUser),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (!snapshots.hasData) {
                return Center(child: Text('Something Went Wrong Try later'));
              } else {
                final List<Message> messages = snapshots.data.docs
                    .map((e) => Message.fromJson(e.data()))
                    .toList();

                return messages.isEmpty
                    ? Center(
                        child: Text(
                          'No message',
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return
                              // Dismissible(
                              //     onDismissed: (_) {
                              //       FirebaseApi.deleteMessage(
                              //           groupchatId, message.idUser);
                              //     },
                              //     key: ValueKey(message.idUser),
                              //     child:
                              MessageWidget(
                            message: message,
                            isMe: message.idUser == myId,
                            isPreviousAreSame: index == (messages.length - 1)
                                ? false
                                : messages[index].idUser ==
                                    messages[index + 1].idUser,
                          );
                        },
                      );
              }
          }
        });
  }

//   Widget buildListMessage() {

//   }
//   // Widget buildText(String text) => Center(
//   //       child: Text(
//   //         text,
//   //         style: TextStyle(fontSize: 24),
//   //       ),
//   //     );
}
