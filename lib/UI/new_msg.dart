//import 'package:firebase_chat_example/api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/Firebase/firebase.dart';
import 'package:flutter_firebase/UI/msg.dart';
import 'package:flutter_firebase/model/message.dart';

import '../mydata.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String name;

  const NewMessageWidget({
    @required this.idUser,
    this.name,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  String groupchatId;

  //String idUser;

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    // FocusScope.of(context)
    //     .requestFocus(new FocusNode());

    //await FirebaseApi.uploadMessage(widget.idUser, message);

    // if (myId.hashCode <= widget.idUser.hashCode) {
    //   groupchatId = '$myId-$widget.idUser';
    // } else {
    //   groupchatId = '$widget.idUser-$myId';
    // }
    await FirebaseApi.uploadgrpMessage(
        groupchatId, message, widget.idUser, widget.name);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[200],
                ),
                child: Icon(Icons.send, color: Colors.black26),
              ),
            ),
          ],
        ),
      );
}
