import 'dart:convert';
//import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/Firebase%20config/firebase_messanging.dart';
import 'package:flutter_firebase/UI/Page1.dart';
import 'package:flutter_firebase/UI/Page2.dart';
import 'package:flutter_firebase/main_screen.dart';
import 'package:flutter_firebase/model/User.dart';
import 'chatlist.dart';

class HomePage extends StatefulWidget {
  //final List<UserModel> users;
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn;

  static const platform =
      MethodChannel('flutter_push_notification/platform_channel');
  String intentData = 'false';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getIntent();
    devicetoken.generateToken();
    platform.setMethodCallHandler(_handleMethod);
    super.initState();
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'notification':
        print('Call Back ${call.arguments}');
        if (call.arguments != null) {
          final jsonResponse = json.decode(call.arguments);
          final payloadStr = jsonResponse['payload'];
          final payload = json.decode(payloadStr);

          if (payload['type'] == 'message') {
            UserModel _user = UserModel(
                idUser: payload['userId'],
                name: payload['name'],
                urlAvatar: payload['user_pic'],
                devicetoken: payload['devicetoken'],
                lastMessageTime: DateTime.now());

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  user: _user,
                ),
              ),
            );
          }
        }
    }
  }

  /// Called when Application is killed or terminated and you user tap on notification.
  Future getIntent() async {
    var getData = await platform.invokeMethod('getIntent');
    if (getData == '{}') {
      getData = null;
    } else {
      getData = getData;
    }
    if (getData != null) {
      intentData = getData;
      if (intentData != 'false') {
        final jsonResponse = json.decode(intentData);
        final payloadStr = jsonResponse['payload'];
        final payload = json.decode(payloadStr);

        if (payload['type'] == 'message') {
          UserModel _user = UserModel(
              idUser: payload['userId'],
              name: payload['name'],
              urlAvatar: payload['user_pic'],
              devicetoken: payload['devicetoken'],
              lastMessageTime: DateTime.now());

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(user: _user),
            ),
          );
        }
        // if (payload['type'] == 'message') {
        //   //Killed Mode
        //   showDialog(
        //       context: context,
        //       builder: (context) {
        //         return AlertDialog(
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.all(
        //               Radius.circular(8.0),
        //             ),
        //           ),
        //           title: Text('Killed mode'),
        //           content: Text(payload.toString()),
        //         );
        //       });
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        backgroundColor: Colors.blue[500],
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout().whenComplete(() {
                Navigator.pushReplacementNamed(context, "/signIn");
                prefs?.setBool("isLoggedIn", false);
              });
            },
          )
        ],
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelColor: Colors.black,
          tabs: [
            Tab(
              child: Text("Chat List"),
            ),
            Tab(
              child: Text("User List"),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          ChatListPage(),
          UserPage(),
        ],
        controller: _tabController,
      ),
    );
  }

  Future logout() async {
    setState(() {
      isLoggedIn = false;
    });
    await _auth.signOut();
  }
}
