//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/main_screen.dart';
//import 'package:flutter_firebase/mydata.dart';
// import 'main_screen.dart';
//import 'package:flutter_firebase/main_screen.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage();
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0)))),
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
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
                    "Login",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
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
      print(newUser.user.uid);
      if (newUser != null) {
        print('Successfully Login');

        final data = await FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.user.uid)
            .get();

        prefs.setString('Name', data.data()['name']);

        //print(prefs.getString('Name'));
        prefs?.setBool("isLoggedIn", true);
        prefs.setString('Uid', newUser.user.uid);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Successfull')));
        Navigator.pushReplacementNamed(context, '/homepage');
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(
                e.message,
              ),
              actions: [
                TextButton(
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
