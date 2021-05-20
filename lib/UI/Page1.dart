//import 'package:firebase_chat_example/model/user.dart';
// import 'package:firebase_chat_example/widget/messages_widget.dart';
// import 'package:firebase_chat_example/widget/new_message_widget.dart';
// import 'package:firebase_chat_example/widget/profile_header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/profile.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/UI/chat_screen.dart';
import 'chat_screen.dart';
import 'msg2.dart';
import 'new_msg.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  // child: MessagesWidget(
                  //   idUser: widget.user.idUser,
                  // ),
                  child: ChatScreen(idUser: widget.user.idUser),
                ),
              ),
              NewMessageWidget(
                  idUser: widget.user.idUser, name: widget.user.name),
            ],
          ),
        ),
      );
}
