import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const String id = "/chatpage";
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  List<DocumentSnapshot> firstData = [];
  List<String> data = [];
  getDataUser() async {
    await _firebaseStore
        .collection('usermoodpost')
        .get()
        .then((QuerySnapshot query) => {
              query.docs.forEach((data) {
                print("${data['emotion']} here is our data");
              })
            });
  }

  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Chat Page"),
      ),
    );
  }
}
