import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserMangement{
  storeNewUseer(user,context){
    FirebaseFirestore.instance.collection('/user').add(
      {'/email':user.email,
      '/uid':user.uid
      }).then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
      ).catchError((e){
        print(e);
      });
  }
}