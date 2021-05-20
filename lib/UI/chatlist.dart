// import 'package:firebase_chat_example/api/firebase_api.dart';
// import 'package:firebase_chat_example/model/user.dart';
// import 'package:firebase_chat_example/widget/chat_body_widget.dart';
// import 'package:firebase_chat_example/widget/chat_header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/model/message.dart';
import '../Utils.dart';
import 'chat_body.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({
    Key key,
  }) : super(key: key);

  //final store = FirebaseFirestore.instance.collection('users');
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  bool _signedIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  // TabController _controller;
  //int _selectedIndex = 0;

  // @override
  // void initState() {
  //   //_controller = TabController(length: 2, vsync: this);
  //   super.initState();
  //   FirebaseAuth.instance.authStateChanges().listen((user) {
  //     if (user is User) {
  //       _signedIn = true;
  //     } else {
  //       _signedIn = false;
  //     }
  //     setState(() {});
  //   });
  // }

  // Future _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   // setState(() {
  //   //   _signedIn = false;
  //   // });
  // }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<UserModel>>(
        stream: FirebaseApi.getChatList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Something Went Wrong Try later'));
              } else {
                final users = snapshot.data;

                if (users.isEmpty) {
                  return Center(child: Text('No Users Found'));
                } else
                  return ChatBodyWidget(users: users);
              }
          }
        },
      );
}
