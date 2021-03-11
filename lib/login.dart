import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/Home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyLoginPage(),
//     );
//   }
// }

class MyLoginPage extends StatefulWidget {
  //final String title;
  MyLoginPage({Key key,}) : super(key: key);
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool showProgress = false;
  //String email, password;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login")),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          //inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                 controller: _emailController,
                  textAlign: TextAlign.center,
                  // onChanged: (value) {
                  //   email = value; // get value from TextField
                  // },
                  decoration: InputDecoration(
                    labelText: "Email",
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(30.0)))),
                  validator: (String value) {
                    if (!regex.hasMatch(value)) {
                      return 'Please enter valid email id';
                    }
                    return null;
                  },
                ),
              ),
              // SizedBox(
              //   height: 20.0,
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: _passwordController,
                  // onChanged: (value) {
                  //   password = value; //get value from textField
                  // },
                  decoration: InputDecoration(
                    labelText: "Password",
                      hintText: "Enter your Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(32.0)))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter the password";
                    } else if (value.length < 6) {
                      return "Password should be atleast 6 characters";
                    } else if (value.length > 15) {
                      return "Password should not be greater than 15 characters";
                    } else
                      return null;
                  },

                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        //autovalidate = true;
                        _login();
                      });
                    }
                    setState(() {
                      showProgress = true;
                    });
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Login", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      //),
    );
  }

  void _login() async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      print(newUser.toString());
      if (newUser != null) {
        print('Successfully Login');
        Fluttertoast.showToast(
            msg: "Login Successfull",);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', newUser.user.displayName);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogoutPage(name: 'Log Out Page',)));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message,),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}