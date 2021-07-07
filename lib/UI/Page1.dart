import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/profile.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/UI/chat_screen.dart';
//import 'package:flutter_firebase/model/message.dart';
import '../mydata.dart';
import 'chat_screen.dart';
import 'new_msg.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;

  ChatPage({this.user});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('active')
        .doc(myId)
        .collection(myId)
        .doc(widget.user.idUser)
        .set({'idUser': widget.user.idUser, 'name': widget.user.name});
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(
                name: widget.user.name,
                idUser: widget.user.idUser,
              ),
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
                idUser: widget.user.idUser,
                name: widget.user.name,
                devicetoken: widget.user.devicetoken,
              ),
            ],
          ),
        ),
      );
}
