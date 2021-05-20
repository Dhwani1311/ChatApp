// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase/Firebase/firebase.dart';
// import 'package:flutter_firebase/model/message.dart';

// import '../mydata.dart';
// import 'msg.dart';

// class MessagesWidget extends StatelessWidget {
//   final String idUser;
//   //final ValueChanged<String> onDelete;

//   const MessagesWidget({
//     @required this.idUser,
//     Key key,
//     //this.onDelete
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => StreamBuilder<List<Message>>(
//         stream: FirebaseApi.getMessages(idUser),
//         builder: (context, snapshots) {
//           switch (snapshots.connectionState) {
//             case ConnectionState.waiting:
//               return Center(child: CircularProgressIndicator());
//             default:
//               if (snapshots.hasError) {
//                 return buildText('Something Went Wrong Try later');
//               } else {
//                 final messages = snapshots.data;

//                 return messages.isEmpty
//                     ? buildText('No message')
//                     : ListView.builder(
//                         physics: BouncingScrollPhysics(),
//                         reverse: true,
//                         itemCount: messages.length,
//                         itemBuilder: (context, index) {
//                           final message = messages[index];
//                           //if (user != null && user.uid == data['author_id']) {
//                           return Dismissible(
//                               onDismissed: (_) {
//                                 //FirebaseApi.deleteMessage(message.idUser);
//                               },
//                               key: ValueKey(message.idUser),
//                               child: MessageWidget(
//                                 message: message,
//                                 isMe: message.idUser == myId,
//                               ));
//                           // }

//                           // return MessageWidget(
//                           //   message: message,
//                           //   isMe: message.idUser == myId,
//                           // );
//                         },
//                       );
//               }
//           }
//         },
//       );

//   Widget buildText(String text) => Center(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 24),
//         ),
//       );

//   // void onDelete(DocumentSnapshot item) {
//   //   FirebaseFirestore.instance
//   //       .collection('chat/$idUser/messages')
//   //       .doc(item.id)
//   //       .delete()
//   //       .then((value) => print('Item Deleted'));
//   // }
// }
