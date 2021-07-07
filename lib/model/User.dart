import 'package:flutter_firebase/main_screen.dart';

import '../utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

// class UserModel {
//   List<UserModelSub> userList = [];

//   UserModel({this.userList});

//   UserModel.fromJson(List<QueryDocumentSnapshot<Map<String, dynamic>>> json) {
//     userList = <UserModelSub>[];
//     json.forEach((user) {
//       userList.add(UserModelSub.fromJson(user.data()));
//     });
//   }
// }

class UserModel {
  final String idUser;
  final String name;
  final String urlAvatar;
  final String devicetoken;
  final String lastmsg;
  final DateTime lastMessageTime;

  UserModel({
    this.idUser,
    this.name,
    this.urlAvatar,
    this.devicetoken,
    this.lastmsg,
    this.lastMessageTime,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json['idUser'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
        devicetoken: json['devicetoken'],
        lastmsg: json['lastmsg'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
        'devicetoken': prefs.getString('devicetoken'),
        'lastmsg': lastmsg,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
