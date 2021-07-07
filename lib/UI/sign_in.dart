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

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ForgotPassword extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Forgot password"),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(
//                   labelText: "Email",
//                   hintText: "Enter Email Id",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                           Radius.circular(30.0)))),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//
//             Material(
//               elevation: 5,
//               color: Colors.lightBlue,
//               borderRadius: BorderRadius.circular(32.0),
//               child: MaterialButton(
//                 onPressed: () async {
//                   resetPassword(context);
//                 },
//                 minWidth: 200.0,
//                 height: 45.0,
//                 child: Text(
//                   "Reset Password",
//                   style:
//                   TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void resetPassword(BuildContext context) async {
//     if (emailController.text.length == 0 || !emailController.text.contains("@")) {
//       Fluttertoast.showToast(msg: "Enter valid email");
//       return;
//     }
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
//     Fluttertoast.showToast(msg:
//         "Reset password link has sent your mail please use it to change the password.");
//     Navigator.pop(context);
//   }
// }

