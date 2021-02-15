import 'package:flutter/material.dart';
import 'main.dart';

void main() => runApp(LogOut());

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLogoutPage(),
    );
  }
}

class MyLogoutPage extends StatefulWidget {
  final String title;
  MyLogoutPage({Key key, this.title}) : super(key: key);
  @override
  _MyLogoutPageState createState() => _MyLogoutPageState();
}

class _MyLogoutPageState extends State<MyLogoutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Logout")),
      ),
      body: Center(
        child:
      OutlineButton(
    child: Text("Logout"),
        onPressed: () {
          //signOutGoogle();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
          // child: _isLoggedIn
          //     ? Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     //Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
          //     //Text(_googleSignIn.currentUser.displayName),
          //     OutlineButton(child: Text("Logout"), onPressed: () {
          //       _logout();
          //     },)
          //   ],
          // )
          ),
    ),);
  }
  //
  // logout(){
  //   _googleSignIn.signOut();
  //   setState(() {
  //     _isLoggedIn = false;
  //     Navigator.pop(
  //       context,
  //       MaterialPageRoute(builder: (context) => MyApp()),
  //     );
  //   });
  // }
}
      // body: Container(
      //   child: Padding(
      //     padding: const EdgeInsets.all(48.0),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: <Widget>[
      //         Center(
      //           child: Text(
      //             'Welcome User',
      //             style: TextStyle(
      //                 fontSize: 25,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black54),
      //           ),
      //         ),

              // RaisedButton(
              //   onPressed: () {
              //     signOutGoogle();
              //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return MyApp();}), ModalRoute.withName('/'));
              //   },
              //   color: Colors.black,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Log Out',
              //       style: TextStyle(fontSize: 25, color: Colors.white),
              //     ),
              //   ),
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(40)),
              // )
//   void signOutGoogle() async{
//     await _googleSignIn.signOut();
//     print("User Sign Out");
//   }
