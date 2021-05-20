import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/Home.dart';
import 'package:flutter_firebase/UI/Page1.dart';
import 'package:flutter_firebase/UI/homepage.dart';
import 'package:flutter_firebase/forgot_password.dart';
import 'package:flutter_firebase/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_sign_in/google_sign_in.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await SharedPreferences.getInstance().then((value) {
//     prefs = value;
//     runApp(MyApp());
//   });
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

SharedPreferences prefs;

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();
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
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                //SizedBox(height: 15,),
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
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Already Registred? Login Now",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // GestureDetector(
                //   child: Container(
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Forgot Password?",
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w500),
                //       )),
                //   onTap: () {
                //     // Navigator.push(context,
                //     //     MaterialPageRoute(builder: (_) => ForgotPassword()));
                //   },
                // ),
                //     SizedBox(
                //       height: 15,
                //     ),
                // _signInButton(),
              ],
            ),
          ),
        ),
      ),
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
            "lastMessageTime": DateTime.now(),
            'urlAvatar':
                'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
          });
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
  // Widget _signInButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {
  //       signInWithGoogle().whenComplete(() {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) {
  //               return LogOut();
  //             },
  //           ),
  //         );
  //       });
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding:  EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;

  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final authResult = await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;

  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);

  //   final User currentUser = _auth.currentUser;
  //   assert(user.uid == currentUser.uid);

  //   return 'signInWithGoogle succeeded: $user';
  // }
  // void signOutGoogle() async{
  //   await googleSignIn.signOut();
  //   print("User Sign Out");
  // }
}
