import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/pages/editprofile.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
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
                    backgroundColor: Colors.white54,
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

Widget profileSection(
  BuildContext context,
  FirebaseFirestore firestoreAcces,
  FirebaseAuth user, {
  String email,
  bool availableStatus,
  String gender,
  String dob,
  String mobile,
  String address,
  String photoUrl,
  String name,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Profile Details',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
      Divider(
        thickness: 1.5,
        color: Colors.grey.shade300,
      ),
      ListTile(
        leading: Icon(
          Icons.mail_outline,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          email,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff272727)),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.trip_origin_outlined,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          "Availablity Status",
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff272727)),
        ),
        trailing: Switch(
          value: availableStatus,
          onChanged: (val) {
            firestoreAcces
                .collection('userdata')
                .doc(user.currentUser.uid)
                .update({'availableStatus': val});
          },
          activeColor: Theme.of(context).primaryColor,
          activeTrackColor: Colors.cyan.shade800,
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.wc,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          gender,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff272727)),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          dob,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff272727)),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.phone_android_outlined,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          mobile,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff272727)),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.location_on_outlined,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text(
          address,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff272727)),
        ),
      ),
    ],
  );
}
