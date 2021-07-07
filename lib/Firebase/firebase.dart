import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/model/message.dart';
import '../main_screen.dart';
import '../mydata.dart';

class FirebaseApi {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy(UserField.lastMessageTime, descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatList() {
    return FirebaseFirestore.instance
        .collection('chatList')
        .doc(prefs.getString('Uid'))
        .collection(prefs.getString('Uid'))
        .orderBy(UserField.lastMessageTime, descending: true)
        .snapshots();
    // .transform(Utils.transformer(UserModel.fromJson));
  }

  static Future deleteMessage(String groupchatId, String idUser) async {
    final refMessages = FirebaseFirestore.instance
        .collection('messages2/$groupchatId/$groupchatId');

    await refMessages.doc(idUser).delete();
  }

  // static Future<void> deleteProduct(
  //     String groupchatId, DocumentSnapshot doc) async {
  //   await FirebaseFirestore.instance
  //       .collection('messages2/$groupchatId/$groupchatId')
  //       .doc(doc.id)
  //       .delete();
  // }

  static Future uploadMessage(String groupchatId, String message, String idUser,
      String name, String devicetoken) async {
    if (myId.hashCode <= idUser.hashCode) {
      groupchatId = '$myId-$idUser';
    } else {
      groupchatId = '$idUser-$myId';
    }

    final refMessages = FirebaseFirestore.instance
        .collection('messages2/$groupchatId/$groupchatId');
    //UserModel user;
    //final user = FirebaseAuth.instance.currentUser;

    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );

    await refMessages.add(newMessage.toJson());

    // final data1 = await FirebaseFirestore.instance
    //     .collection('messages2')
    //     .doc(groupchatId)
    //     .collection(groupchatId)
    //     .where('idUser', isEqualTo: myId)
    //     .orderBy('createdAt', descending: true)
    //     .limit(1)
    //     .get();
    // print(data1.docs);

    final refUsers = FirebaseFirestore.instance
        .collection('chatList')
        .doc(myId)
        .collection(myId);

    final chatlist = UserModel(
        idUser: idUser,
        name: name,
        lastmsg: message,
        devicetoken: devicetoken,
        urlAvatar: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
        lastMessageTime: DateTime.now());

    await refUsers.doc(idUser).set(chatlist.toJson());

    final refUsers2 = FirebaseFirestore.instance
        .collection('chatList')
        .doc(idUser)
        .collection(idUser);

    final chatlist2 = UserModel(
        idUser: myId,
        name: myUsername,
        lastmsg: message,
        devicetoken: prefs.getString('devicetoken'),
        urlAvatar: 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
        lastMessageTime: DateTime.now());

    await refUsers2.doc(myId).set(chatlist2.toJson());

    // await refUsers.doc(idUser).set({
    //   'idUser': idUser,
    //   'name': name,
    //   'devicetoken': token,
    //   'urlAvatar': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
    //   'lastMessageTime': DateTime.now()
    // });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getGroupId(
      String groupchatId, String idUser) {
    if (myId.hashCode <= idUser.hashCode) {
      groupchatId = '$myId-$idUser';
    } else {
      groupchatId = '$idUser-$myId';
    }
    return FirebaseFirestore.instance
        .collection('messages2/$groupchatId/$groupchatId')
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots();
    // .transform(Utils.transformer(Message.fromJson));
  }
}
