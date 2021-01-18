import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/models/contactsmodel.dart';

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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 0.0,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: Colors.indigo,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              labelStyle: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
              //labelColor: Theme.of(context).primaryColor,
              tabs: <Widget>[
                Tab(
                  text: "Recents",
                ),
                Tab(
                  text: "Contacts",
                ),
              ],
            ),
          ),
        ),
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
                      backgroundColor: Colors.white54,
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

class ExpandTiles extends StatefulWidget {
  ContactModel userDetails;
  ExpandTiles({this.userDetails});

  @override
  _ExpandTilesState createState() => _ExpandTilesState();
}

class _ExpandTilesState extends State<ExpandTiles> {
  bool _isExpanded = false;

  void _expandFunc() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(widget.userDetails.photoUrl),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      widget.userDetails.name,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  _isExpanded
                      ? IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            size: 25.0,
                          ),
                          onPressed: () => _expandFunc(),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            size: 25.0,
                          ),
                          onPressed: () => _expandFunc(),
                        )
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isExpanded,
            child: Container(
              height: 130.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email:- ",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.userDetails.email,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile:- ",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.userDetails.mobile,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address:- ",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.userDetails.address,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
