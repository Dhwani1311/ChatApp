// Napoleon
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//SharedPreferences pref;
//final user = FirebaseAuth.instance.currentUser;
String myId = prefs.getString('Uid') ?? 'jU0VJJGLaQRb3ZKIAy7V';
String myUsername = prefs.getString('Name') ?? 'TestUser';
String myUrlAvatar = 'https://homepages.cae.wisc.edu/~ece533/images/cat.png';

//final user = FirebaseAuth.instance.currentUser;
// String myId = '11';
// String myUsername = 'TestUser';
// String myUrlAvatar = 'https://homepages.cae.wisc.edu/~ece533/images/cat.png';
