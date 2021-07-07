//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/model/message.dart';
//import 'package:flutter_firebase/mydata.dart';

class MessageWidget extends StatefulWidget {
  final Message message;
  final bool isMe;
  final bool isPreviousAreSame;

  MessageWidget({this.message, this.isMe, this.isPreviousAreSame});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!widget.isMe)
          widget.isPreviousAreSame && widget.isPreviousAreSame != null
              ? SizedBox(
                  width: 30,
                )
              : CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.message.urlAvatar)),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color:
                widget.isMe ? Colors.grey[100] : Theme.of(context).accentColor,
            borderRadius: widget.isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.message.message,
                style:
                    TextStyle(color: widget.isMe ? Colors.black : Colors.white),
                textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
        if (widget.isMe)
          widget.isPreviousAreSame && widget.isPreviousAreSame != null
              ? SizedBox(
                  width: 30,
                )
              : CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.message.urlAvatar)),
      ],
    );
  }
}
// Widget buildMessage() => Column(
//   crossAxisAlignment:
//   isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//   children: <Widget>[
//     Text(
//       message.message,
//       style: TextStyle(color: isMe ? Colors.black : Colors.white),
//       textAlign: isMe ? TextAlign.end : TextAlign.start,
//     ),
//   ],
// );
//}
