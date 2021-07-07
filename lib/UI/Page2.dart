// import 'package:firebase_chat_example/api/firebase_api.dart';
// import 'package:firebase_chat_example/model/user.dart';
// import 'package:firebase_chat_example/widget/chat_body_widget.dart';
// import 'package:firebase_chat_example/widget/chat_header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/model/User.dart';
import 'chat_body.dart';

class UserPage extends StatefulWidget {
  UserPage();
  //final store = FirebaseFirestore.instance.collection('users');
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  String idUser;

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseApi.getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<UserModel> _list = snapshot.data.docs
              .map((e) => UserModel.fromJson(e.data()))
              .toList();
          return ChatBodyWidget(users: _list);

          // switch (snapshot.connectionState) {
          //   case ConnectionState.waiting:
          //     return Center(child: CircularProgressIndicator());
          //   default:
          //     if (snapshot.hasError) {
          //       print(snapshot.error);
          //       return Center(child: Text('Something Went Wrong Try later'));
          //     } else {
          //       final QuerySnapshot<Map<String, dynamic>> users = snapshot.data;

          //       if (users.docs.isEmpty) {
          //         return Center(child: Text('No Users Found'));
          //       } else {
          //         List<UserModel> _list = users.docs
          //             .map((e) => UserModel.fromJson(e.data()))
          //             .toList();
          //         return ChatBodyWidget(users: _list);
          //       }
          //     }
          // }
        },
      );
}
