import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/chatservice/chatstile.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

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
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: widget.searchResults.docs.length == 0
          ? Center(
              child: Text(
                "No Result Found!!!",
                style: AppTextStyles.searchChatResultNotFoundStyle(),
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
