import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/model/User.dart';
//import 'package:flutter_firebase/model/message.dart';
import 'chat_body.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage();

  //final store = FirebaseFirestore.instance.collection('users');
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  @override
  // void initState() {

  //   getLastMessage();
  //   super.initState();
  // }

  // void getLastMessage( ) async {
  //   final data1 = await FirebaseFirestore.instance
  //       .collection('message/$groupchatId/$groupchatId')
  //       .orderBy(UserField.lastMessageTime, descending: true)
  //       .limit(1)
  //       .get();

  //   print(data1.docs);
  // }

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseApi.getChatList(),
        builder: (context, snapshot) {
          //print(snapshot.data.docs);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //return Container();
            // return ChatBodyWidget();
            List<UserModel> _list = snapshot.data.docs
                .map((e) => UserModel.fromJson(e.data()))
                .toList();

            if (_list.isEmpty) {
              return Center(child: Text('No Users Found'));
            } else {
              return ChatBodyWidget(users: _list);
            }
          }

          // switch (snapshot.connectionState) {
          //   case ConnectionState.waiting:
          //     return Center(child: CircularProgressIndicator());
          //   default:
          //     if (snapshot.hasError) {
          //       print(snapshot.error);
          //       return Center(child: Text('Something Went Wrong Try later'));
          //     } else {
          //       final users = snapshot.data;

          //       if (users.isEmpty) {
          //         return Center(child: Text('No Users Found'));
          //       } else
          //         return ChatBodyWidget(users: users);
          //     }
          // }
        },
      );
}
