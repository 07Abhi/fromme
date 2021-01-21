import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/widgets/profilesection.dart';

class ProfilePage extends StatefulWidget {
  static const String id = "/profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot userData;
  bool isAvailable = false;

  Future<DocumentSnapshot> fetchData() async {
    userData = await _firestore
        .collection('userdata')
        .doc(_firebaseAuth.currentUser.uid)
        .get();
    return userData;
  }

  Future<void> onRefresh() async {
    var data = await _firestore
        .collection('userdata')
        .doc(_firebaseAuth.currentUser.uid)
        .get();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: AppColor.statusBarColor));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(children: [
          FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot profileData = snapshot.data;
                return profileSection(
                  context,
                  _firestore,
                  _firebaseAuth,
                  email: profileData['email'] ?? "email",
                  availableStatus: profileData['availableStatus'] ?? false,
                  gender: profileData['gender'] ?? "gender",
                  dob: profileData['dob'] ?? "dob",
                  mobile: profileData['mobile'] ?? "mobile",
                  address: profileData['address'] ?? "address",
                  photoUrl: profileData['photoUrl'] ??
                      "https://image.flaticon.com/icons/png/512/64/64572.png",
                  name: profileData['name'] ?? "name",
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.circularProgressIndiColor,
                    strokeWidth: 5.0,
                  ),
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}

