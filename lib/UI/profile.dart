import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../mydata.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String idUser;

  ProfileHeaderWidget({this.name, this.idUser});

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  color: Colors.white,
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('active')
                        .doc(myId)
                        .collection(myId)
                        .doc(idUser)
                        .delete();
                    Navigator.pop(context);
                  },
                  // icon: Icon(Icons.arrow_back_ios)
                ),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
