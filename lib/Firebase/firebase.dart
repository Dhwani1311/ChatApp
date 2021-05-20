import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/main_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_chat_example/data.dart';
// import 'package:firebase_chat_example/model/message.dart';
// import 'package:firebase_chat_example/model/user.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/model/message.dart';

import '../mydata.dart';
import '../utils.dart';

class FirebaseApi {
  static Stream<List<UserModel>> getUsers(String idUser) {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy(UserField.lastMessageTime, descending: true)
        .snapshots()
        .transform(Utils.transformer(UserModel.fromJson));
  }

  static Stream<List<UserModel>> getChatList() => FirebaseFirestore.instance
      .collection('chatList')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(UserModel.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    UserModel userModel;
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');
    //final user = FirebaseAuth.instance.currentUser;
    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('chatList');
    await refUsers.doc(idUser).set({
      'idUser': idUser,
      'name': userModel.name ?? 'TestUser',
      'urlAvatar': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
      'lastMessageTime': DateTime.now()
    });
    //.set({UserField.lastMessageTime.toString(): DateTime.now()});
  }

  static Future deleteMessage(String idUser, String groupchatId) async {
    final refMessages = FirebaseFirestore.instance
        .collection('messages2/$groupchatId/$groupchatId');

    await refMessages.doc(idUser).delete();

    // final refUsers = FirebaseFirestore.instance.collection('user');
    // await refUsers
    //     .doc(idUser)
    //     .set({UserField.lastMessageTime.toString(): DateTime.now()});
  }

  static Future uploadgrpMessage(
      String groupchatId, String message, String idUser, String name) async {
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

    final refUsers = FirebaseFirestore.instance.collection('chatList');
    await refUsers.doc(idUser).set({
      'idUser': idUser,
      'name': name,
      'urlAvatar': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
      'lastMessageTime': DateTime.now()
    });

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(myId)
    //     .update({'chattingWith': idUser});

    // final refUsers = FirebaseFirestore.instance.collection('chatList');
    // await refUsers.doc(groupchatId).set({
    //   'idUser': myId,
    //   'name': prefs.getString('Name') ?? 'TestUser',
    //   'urlAvatar': 'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
    //   'lastMessageTime': DateTime.now()
    // });
    // //.set({UserField.lastMessageTime.toString(): DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) {
    return FirebaseFirestore.instance
        .collection('chats/$idUser/messages')
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));
  }

  static Stream<List<Message>> getGroupId(String groupchatId, String idUser) {
    if (myId.hashCode <= idUser.hashCode) {
      groupchatId = '$myId-$idUser';
    } else {
      groupchatId = '$idUser-$myId';
    }
    return FirebaseFirestore.instance
        .collection('messages2/$groupchatId/$groupchatId')
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));
  }

  static Future addRandomUsers(List<UserModel> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
