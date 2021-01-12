import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/chatservice/chatdatabase/chatdatabaseaccess.dart';
import 'package:fromme/chatservice/chatstile.dart';
import 'package:fromme/chatservice/searchresult.dart';
import 'package:toast/toast.dart';

class Userdata {
  String uid;
  String imgUrl;
  String name;
  bool isOnline;
  Userdata({this.uid, this.imgUrl, this.name, this.isOnline});
}

class ChatPage extends StatefulWidget {
  static const String id = "/chatpage";
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Userdata> users = [];
  TextEditingController _searchController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  QuerySnapshot chatHeads;
  QuerySnapshot searchResults;
  List<DocumentSnapshot> firstData = [];
  List<String> data = [];
  String currentUserName;
  String currentUserEmail;

  Future<QuerySnapshot> getChatHeads() async {
    chatHeads = await _firebaseStore.collection('userdata').get();
    return chatHeads;
  }

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

  checkSearchResults(String username) async {
    QuerySnapshot data = await DatabaseAccess().getUserByNameSearch(username);
    setState(() {
      searchResults = data;
    });
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    _searchController.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(
          searchResults: searchResults,
        ),
      ),
    );
  }

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: getChatHeads(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white54,
                  strokeWidth: 5.0,
                ),
              );
            }
            users = [];
            snapshot.data.docs.forEach(
              (data) {
                if (_auth.currentUser.email != data['email']) {
                  users.add(
                    Userdata(
                      uid: data['uid'],
                      name: data['name'],
                      imgUrl: data['photoUrl'],
                      isOnline: data['isOnline'],
                    ),
                  );
                }
              },
            );
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          keyboardType: TextInputType.name,
                          maxLength: 30,
                          buildCounter: (context,
                                  {currentLength, isFocused, maxLength}) =>
                              null,
                          decoration: InputDecoration(
                            hintText: "Search.....",
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade400,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 35.0,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          if (_searchController.text == currentUserName) {
                            Toast.show("Not Available", context,
                                duration: 2,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Theme.of(context).primaryColor,
                                textColor: Colors.white);
                          } else {
                            if (_searchController.text.isNotEmpty) {
                              checkSearchResults(_searchController.text);
                            } else {
                              Toast.show("Empty Search!!!", context,
                                  duration: 2,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  textColor: Colors.white);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ChatTiles(
                        imgUrl: users[index].imgUrl,
                        uid: users[index].uid,
                        name: users[index].name,
                        isOnline: users[index].isOnline,
                        currentUserEmail: currentUserEmail,
                        currentUserName: currentUserName,
                      ),
                    ),
                    itemCount: users.length,
                    shrinkWrap: true,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}