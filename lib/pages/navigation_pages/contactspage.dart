import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/models/contactsmodel.dart';

import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/widgets/expandedtiles.dart';

class ContactPage extends StatefulWidget {
  static const String id = "/contactpage";
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  QuerySnapshot userData;
  List<ContactModel> contactsData = [];
  Future<QuerySnapshot> getUserContacts() async {
    userData = await _firebaseFirestore.collection('userdata').get();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppConstantsWidgets.appBarConatactsPage(),
        body: TabBarView(
          children: [
            Center(
              child: Text("Under Development"),
            ),
            FutureBuilder<QuerySnapshot>(
              future: getUserContacts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColor.circularProgressIndiColor,
                      strokeWidth: 5.0,
                    ),
                  );
                }
                contactsData = [];
                snapshot.data.docs.forEach(
                  (data) {
                    if (_auth.currentUser.email != data['email']) {
                      contactsData.add(
                        ContactModel(
                          name: data['name'],
                          address: data['address'],
                          mobile: data['mobile'],
                          email: data['email'],
                          photoUrl: data['photoUrl'],
                        ),
                      );
                    }
                  },
                );
                return ListView.builder(
                  itemCount: contactsData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ExpandTiles(
                      userDetails: contactsData[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
