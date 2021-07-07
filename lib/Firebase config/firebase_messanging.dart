import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../main_screen.dart';

class DeviceToken {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> generateToken() async {
    final devicetoken = await firebaseMessaging.getToken();

    DocumentReference documentReference =
        firestore.collection('users').doc(prefs.getString('Uid'));
    documentReference.update({'devicetoken': devicetoken});
    print(devicetoken);
    // print(prefs.getString('Uid'));
    prefs.setString('devicetoken', devicetoken);
  }
}

DeviceToken devicetoken = DeviceToken();
