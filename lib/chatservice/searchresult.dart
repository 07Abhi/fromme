import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/chatservice/chatstile.dart';

class SearchResultPage extends StatefulWidget {
  final QuerySnapshot searchResults;
  SearchResultPage({this.searchResults});
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  String currentUserName;
  String currentUserEmail;

  getCurrentUserData() async {
    DocumentSnapshot data = await _firebaseStore
        .collection('userdata')
        .doc(_auth.currentUser.uid)
        .get();
    setState(() {
      currentUserName = data['name'];
      currentUserEmail = data['email'];
    });
  }

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0.0,
          shadowColor: Colors.white,
          title: Text(
            "FromMe",
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w600,
              color: Colors.cyan.shade400,
              fontFamily: "LovedByTheKing",
              shadows: [
                Shadow(
                  offset: Offset(0, 3.0),
                  blurRadius: 2.0,
                  color: Colors.grey.shade400,
                )
              ],
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff41b1c0),
                  Colors.white,
                ],
                stops: [
                  0.1,
                  0.8,
                ],
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              size: 40.0,
              color: Color(0xff2DC4D9),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: widget.searchResults.docs.length == 0
          ? Center(
              child: Text(
                "No Result Found!!!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.searchResults.docs.length,
              itemBuilder: (context, index) {
                var data = widget.searchResults.docs[index].data();
                return ChatTiles(
                  imgUrl: data['photoUrl'],
                  name: data['name'],
                  isOnline: data['isOnline'],
                  uid: data['uid'],
                  currentUserEmail: currentUserEmail,
                  currentUserName: currentUserName,
                );
              },
            ),
    );
  }
}
