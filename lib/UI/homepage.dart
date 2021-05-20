import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/Page2.dart';
import 'package:flutter_firebase/login.dart';

import 'chatlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedIn;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
          ChatsPage(),
        ],
        controller: _tabController,
      ),
    );
  }

  Future logout() async {
    setState(() {
      _isLoggedIn = false;
    });
    await _auth.signOut();
  }
}
