import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_firebase/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

SharedPreferences prefs;

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool reg = false;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Register")),
      ),
      body: SingleChildScrollView(
        //child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                "Registration",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter your Name",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0)))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  // onChanged: (value) {
                  //   email = value;
                  // },
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your Email Id",
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
              //SizedBox(height: 15,),
              //padding2,
              // SizedBox(
              //   height: 15.0,
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0)))),
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
              // SizedBox(
              //   height: 15.0,
              // ),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _register();
                      });
                    }
                    setState(() {
                      reg = true;
                    });
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Register",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MyLoginPage(
                  //             name: _nameController.text,
                  //           )),
                  // );
                },
                child: Text(
                  "Already Registred? Login Now",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }

  void _register() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((newuser) async {
        if (newuser.user.uid != null) {
          print(newuser.user.uid);
          print('Successfully registered.');
          //Fluttertoast.showToast(msg: "Successfully registered.");
          FirebaseFirestore.instance
              .collection("users")
              .doc(newuser.user.uid)
              .set({
            "idUser": newuser.user.uid,
            "name": _nameController.text,
            // "devicetoken": prefs.getString('devicetoken'),
            "lastMessageTime": DateTime.now(),
            'urlAvatar':
                'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
          });
          print((prefs.getString('devicetoken')));
          prefs.setString('Uid', newuser.user.uid);
          prefs.setString('Name', _nameController.text);
          prefs.setString('Time', DateTime.now().toString());

          Navigator.pushReplacementNamed(context, '/homepage');
        }
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
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
