import 'package:flutter_firebase/Firebase/firebase.dart';

import 'package:flutter_firebase/UI/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/login.dart';
import 'package:flutter_firebase/mydata.dart';
import 'package:flutter_firebase/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/homepage.dart';
import 'Users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseApi.addRandomUsers(Users.initUsers);

  await SharedPreferences.getInstance().then((value) {
    prefs = value;
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var status = prefs.getBool('isLoggedIn') ?? false;
    prefs?.setBool("isLoggedIn", true);
    print(status);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatApp',
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.black87)),
      home: status == true ? HomePage() : MyHomePage(),
      //initialRoute: '/signIn',
      routes: {
        "/signIn": (_) => MyHomePage(),
        "/homepage": (_) => HomePage(),
        '/login': (_) => MyLoginPage()
      },
    );
  }
}
