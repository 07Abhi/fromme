import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/models/moodpostmodel.dart';
import 'package:fromme/models/statusmodel.dart';
import 'package:fromme/widgets/userposts.dart';
import 'package:fromme/widgets/userstatusbar.dart';

class TimeLinePage extends StatefulWidget {
  static const String id = "/timelinepage";

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<StatusModel> _statusInfo = [];
  List<MoodPostData> _moodposts = [];
  QuerySnapshot database;
  bool isLoading = false;

  getPostData() async {
    print("hello world");
  }

  Future<QuerySnapshot> getUserStoryTiles() async {
    final data = await _firestore
        .collection('userdata')
        .doc(_auth.currentUser.uid)
        .get();
    String name = data['name'];
    String photoUrl = data['photoUrl'];
    await _firestore
        .collection('usermoodpost')
        .doc('allmoodpost')
        .collection('moodposts')
        .get()
        .then(
          (QuerySnapshot data) => {
            data.docs.forEach(
              (element) {
                _moodposts.add(
                  MoodPostData(
                    name: element['name'],
                    postData: element['postMessage'],
                    photoUrl: element['postImageUrl'],
                    emotion: element['emotion'],
                  ),
                );
              },
            )
          },
        );
    database = await _firestore.collection('userdata').get();
    return database;
  }

  @override
  void initState() {
    getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: getUserStoryTiles(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white54,
                strokeWidth: 5.0,
              ),
            );
          }
          snapshot.data.docs.forEach(
            (data) {
              _statusInfo.add(
                StatusModel(
                  isOnline: data['isOnline'],
                  photoUrl: data['photoUrl'],
                ),
              );
            },
          );
          return Column(
            children: [
              userStatusBar(context, _statusInfo),
              SizedBox(
                height: 20.0,
              ),
              Expanded(child: userPostsContainer(context, _moodposts))
            ],
          );
        },
      ),
    );
  }
}
