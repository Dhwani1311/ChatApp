import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/Page1.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/mydata.dart';

class ChatBodyWidget extends StatefulWidget {
  final List<UserModel> users;

  ChatBodyWidget({
    this.users,
  });

  @override
  _ChatBodyWidgetState createState() => _ChatBodyWidgetState();
}

class _ChatBodyWidgetState extends State<ChatBodyWidget> {
  // ScrollController controller;

  @override
  Widget build(BuildContext context) =>
      // Scaffold(
      //       body: Scrollbar(
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: buildChats(),
      );

  Widget buildChats() => ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          final user = widget.users[index];
          if (user.idUser != myId) {
            return InkWell(
              // child: user.idUser != myId
              //     ? Container(
              // height: user.idUser != myId ? 55.0 : 0.0,
              // width: MediaQuery.of(context).size.width,
              child: Container(
                height: 65,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatPage(user: user),
                    ));
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.urlAvatar),
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    user.lastmsg == null ? '' : user.lastmsg,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            );
            // : Container());
          }
          return Container();
          //return CircularProgressIndicator();
        },
        // separatorBuilder: (context, index) {
        //   return widget.users[index].idUser != myId
        //       ? Divider()
        //       : Container(); // this line hide the devider for specific cell..
        // },
      );
}
