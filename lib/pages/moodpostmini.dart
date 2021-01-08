import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:fromme/pages/homebookmark.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MoodPostMini extends StatefulWidget {
  static const String id = "/moodpostmini";

  @override
  _MoodPostMiniState createState() => _MoodPostMiniState();
}

class _MoodPostMiniState extends State<MoodPostMini> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController _postMessageController = new TextEditingController();
  DocumentSnapshot userData;
  File pickFile;
  String imageUrl;

  Future<DocumentSnapshot> fetchData() async {
    userData = await _firestore
        .collection('userdata')
        .doc(_firebaseAuth.currentUser.uid)
        .get();
    return userData;
  }

  Future<void> uploadImage(BuildContext context) async {
    File image;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Upload Picture"),
        children: [
          RaisedButton(
            onPressed: () async {
              PickedFile pickImage =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              image = File(pickImage.path);
              Navigator.of(context).pop();
              final reference = _storage.ref().child('moodPostPhotos/');
              final uploadTask = reference.putFile(image);
              uploadTask.whenComplete(() {
                setState(() async {
                  print("photo is done");
                  pickFile = image;
                  imageUrl = await reference.getDownloadURL();
                  print(imageUrl);
                });
              });
              Toast.show(
                "Image Uploaded",
                context,
                duration: 3,
                gravity: Toast.BOTTOM,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              );
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              "Choose from gallery",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              PickedFile pickImage =
                  await ImagePicker().getImage(source: ImageSource.camera);
              image = File(pickImage.path);
              Navigator.of(context).pop();
              final reference = _storage.ref().child('moodPostPhotos/');
              final uploadTask = reference.putFile(image);
              uploadTask.whenComplete(() {
                setState(() async {
                  pickFile = image;
                  imageUrl = await reference.getDownloadURL();
                  print(imageUrl);
                });
              });
              Toast.show(
                "Image Uploaded",
                context,
                duration: 3,
                gravity: Toast.BOTTOM,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              );
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              "Camera",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Consumer<MoodManager>(
        builder: (context, moodTask, child) => FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot profileData = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 70.0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage(profileData['photoUrl']),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, HomeBookMark.id);
                            },
                            child: Text(
                              "Emotion",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff27AE60),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.grey.shade200,
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _postMessageController,
                        maxLength: 200,
                        maxLines: 7,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                        buildCounter: (context,
                                {currentLength, isFocused, maxLength}) =>
                            null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Write Your Post",
                          hintStyle: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffc0c0c0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.grey.shade200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.camera_alt_outlined,
                          size: 40.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          "Add Photo/Video",
                          style: TextStyle(fontSize: 13.0),
                        ),
                        onTap: () {
                          uploadImage(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                insetPadding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "Search",
                                            hintStyle: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 2.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 2.0),
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage: AssetImage(
                                                  "assets/userlogo.png"),
                                            ),
                                            title: Text(
                                              "User Name",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            trailing: Checkbox(
                                              onChanged: (data) {},
                                              value: false,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 20.0),
                                          child: Container(
                                            height: 50.0,
                                            width: 300.0,
                                            child: Center(
                                              child: Text(
                                                "Users Name that are selected",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 5.0,
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward,
                                              size: 40.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {},
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            child: Container(
                              height: 35.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Choose who to share with',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: () {
                              try {
                                _firestore
                                    .collection('usermoodpost')
                                    .doc(_firebaseAuth.currentUser.uid)
                                    .collection('moodposts')
                                    .add({
                                  "postMessage": _postMessageController.text,
                                  "emotion": moodTask.getMood(),
                                  "postImageUrl": imageUrl,
                                });
                                _postMessageController.clear();
                                Toast.show(
                                  "Post Successfully Uploaded",
                                  context,
                                  duration: 3,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                );
                              } catch (e) {
                                print("Something went wrong");
                              }
                            },
                            child: Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            color: Color(0xffc0c0c0),
                          )
                        ],
                      )
                    ],
                  ),
                ],
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
      ),
    );
  }
}
