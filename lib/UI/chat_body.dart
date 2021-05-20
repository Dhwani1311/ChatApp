import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/Page1.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/mydata.dart';

class ChatBodyWidget extends StatefulWidget {
  final List<UserModel> users;

  const ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  _ChatBodyWidgetState createState() => _ChatBodyWidgetState();
}

class _ChatBodyWidgetState extends State<ChatBodyWidget> {
  ScrollController controller;
  // List<String> items = new List.generate(100, (index) => 'Hello $index');

  // @override
  // void initState() {
  //   super.initState();
  //   controller = new ScrollController()..addListener(_scrollListener);
  // }

  // @override
  // void dispose() {
  //   controller.removeListener(_scrollListener);
  //   super.dispose();
  // }

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
        //   ),
        // ),
      );

  Widget buildChats() => ListView.separated(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          final user = widget.users[index];
          return InkWell(
            //onTap: () {},
            child: Container(
              height: user.idUser != myId ? 55.0 : 0.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 75,
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
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return widget.users[index].idUser != myId
              ? Divider()
              : Container(); // this line hide the devider for specific cell..
        },
      );
  // ListView.builder(
  //   physics: BouncingScrollPhysics(),
  //   controller: controller,
  //   itemCount: widget.users.length,
  //   itemBuilder: (context, index) {
  //     final user = widget.users[index];
  //     return Container(
  //       height: user.idUser != myId ? 70.0 : 0.0,
  //       width: MediaQuery.of(context).size.width,
  //       child: Container(
  //         height: 75,
  //         child: ListTile(
  //           onTap: () {
  //             Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => ChatPage(user: user),
  //             ));
  //           },
  //           leading: CircleAvatar(
  //             radius: 25,
  //             backgroundImage: NetworkImage(user.urlAvatar),
  //           ),
  //           title: Text(
  //             user.name,
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  // );

  // void _scrollListener() {
  //   print(controller.position.extentAfter);
  //   if (controller.position.extentAfter < 500) {
  //     setState(() {
  //       widget.users.addAll(
  //           new List<UserModel>.generate(40, (index) => widget.users[index]));
  //     });
  //   }
  // }
}
