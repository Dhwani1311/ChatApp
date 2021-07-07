import 'package:flutter_firebase/UI/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/login.dart';
import 'package:flutter_firebase/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SharedPreferences.getInstance().then((value) {
    prefs = value;
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatApp',
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.black87)),
      home: status == true ? HomePage() : MyHomePage(),
      //initialRoute: '/signIn',
      //home: HomePage(),
      routes: {
        "/signIn": (_) => MyHomePage(),
        "/homepage": (_) => HomePage(),
        "/login": (_) => MyLoginPage(),
      },
    );
  }
}
