import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final firestoreInstance = FirebaseFirestore.instance;
  final TextEditingController textData = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _signOut().whenComplete(() {
                  Navigator.pushReplacementNamed(context, "/signIn");
                });
              },
            )
          ],
        ),
        body: Stack(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Column(
                      children: [
                        Container(
                          child: Center(
                              child: ListTile(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Alert!!"),
                                    content: Text(
                                        "You won't to delete this meassage"),
                                    actions: [
                                      TextButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Delete"),
                                        onPressed: () {
                                          deleteProduct(
                                            document,
                                          ).then((value) =>
                                              Navigator.of(context).pop());
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            title: Text(
                              document['message'],
                            ),
                          )),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: TextFormField(
                    controller: textData,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.black87,
                            ),
                            onPressed: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              createRecord(textData.text);
                            }),
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void createRecord(dynamic msg) async {
    DocumentReference ref = await databaseReference.collection("user").add({
      'message': msg,
    });
    textData.clear();
    print(ref.id);
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteProduct(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance.collection("user").doc(doc.id).delete();
  }
}
