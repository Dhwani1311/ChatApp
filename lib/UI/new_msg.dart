//import 'package:firebase_chat_example/api/firebase_api.dart';
import 'dart:convert';
import 'dart:io';
//import 'package:flutter_firebase/mydata.dart';
//import 'package:flutter_firebase/model/User.dart';
//import 'package:flutter_firebase/mydata.dart';
//import 'package:flutter_firebase/Firebase%20config/firebase_messanging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/mydata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String name;
  final String devicetoken;

  NewMessageWidget({
    this.idUser,
    this.name,
    this.devicetoken,
  });

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  String groupchatId;

  Future sendMessage() async {
    FocusScope.of(context).unfocus();
    //For checking user are present in chat room or not

    final sendNotificationHelper = await FirebaseFirestore.instance
        .collection('active')
        .doc(widget.idUser)
        .collection(widget.idUser)
        .where('idUser', isEqualTo: myId)
        .get();

    _controller.clear();
    //Add this on init state on chat room

    // FirebaseFirestore.instance
    //     .collection('active')
    //     .doc(myId)
    //     .collection(myId)
    //     .doc(widget.idUser)
    //     .set({'idUser': widget.idUser, 'name': widget.name});

    //excute this on when user leave the chat room.

    // FirebaseFirestore.instance
    //     .collection('active')
    //     .doc(myId)
    //     .collection(myId)
    //     .doc(widget.idUser)
    //     .delete();

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.idUser)
        .get();

    await FirebaseApi.uploadMessage(groupchatId, message, widget.idUser,
        widget.name, userData.data()['devicetoken']);

    //print(widget.devicetoken);

    if (sendNotificationHelper.docs.isEmpty) {
      sendNotification(userData.data()['devicetoken']);
    }
  }

  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future sendNotification(String token) async {
    // final String token = await _firebaseMessaging.getToken();

    Map pushNotificationData = {
      'type': 'message',
      'data': message,
      'name': myUsername,
      'userId': myId,
      'devicetoken': token
      //'devicetoken': deviceToken,
    };

    final data = json.encode(pushNotificationData);

    Map<String, dynamic> pushNotificationPayload = {
      "to": token,
      "priority": "high",
      "data": {
        "payload": data,
        "title": myUsername,
        "user_pic":
            "https://firebasestorage.googleapis.com/v0/b/flutter-push-notificatio-d8959.appspot.com/o/1.png?alt=media&token=fd6bf269-fa83-4e96-a089-baf883759b3f",
        "subtitle": message
      },
      "notification": {
        "body": message,
        "title": myUsername,
        "sound": "default",
        "badge": "1"
      }
    };
    await createNotification(json.encode(pushNotificationPayload));
    // sentTextToNotificationController.clear();
  }

  Future<http.Response> createNotification(String data) async {
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'key=' +
            'AAAALBy9oIg:APA91bGGGe3j3Pt3jdexaPOT9SXFE-hdqQa8wyAiTgz509e17qA6jFrPKAcygNWwKnRWT_o5ub7L4CKfzy72GN2pM_wkCQ6T34RQQQWrej60G4LUNJZi2x1gEgHbQYMCZYC71zn0ElW-',
      },
      body: data,
    );
    print(response.body);
    return response;
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: (message.trim().isEmpty
                  ? null
                  : () {
                      sendMessage();
                    }),
              // onTap: () {
              //   sendMessage(widget.devicetoken);
              // },

              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[200],
                ),
                child: Icon(Icons.send, color: Colors.black26),
              ),
            ),
          ],
        ),
      );
}
