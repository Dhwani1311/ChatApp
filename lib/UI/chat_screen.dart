import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/UI/msg.dart';
import 'package:flutter_firebase/main_screen.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/model/message.dart';

import '../mydata.dart';

class ChatScreen extends StatefulWidget {
  final String idUser;
  //final ValueChanged<String> onDelete;

  const ChatScreen({
    @required this.idUser,
    Key key,
    //this.onDelete
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ChatScreen> {
  String groupchatId;

  @override
  Widget build(BuildContext context) {
    return buildListMessage();
  }

  Widget buildListMessage() {
    return StreamBuilder<List<Message>>(
        stream: FirebaseApi.getGroupId(groupchatId, widget.idUser),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshots.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshots.data;

                return messages.isEmpty
                    ? buildText('No message')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return Dismissible(
                              onDismissed: (_) {
                                FirebaseApi.deleteMessage(
                                    groupchatId, message.idUser);
                              },
                              key: ValueKey(messages[index].idUser),
                              child: MessageWidget(
                                message: message,
                                isMe: message.idUser == myId,
                              ));
                        },
                      );
              }
          }
        });
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
