import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fromme/backend_services/login_database.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:fromme/pages/homebookmark.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_strings.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


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
  bool isImage = false;

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
              final reference = _storage
                  .ref()
                  .child('${_firebaseAuth.currentUser.uid}mood post/');
              final uploadTask = reference.putFile(image);
              uploadTask.whenComplete(() async {
                imageUrl = await reference.getDownloadURL();
              });
              setState(() {
                isImage = true;
                pickFile = image;
              });
              AppConstantsWidgets.appToastDisplay(context,
                  info: "Image Uploaded!!");
            },
            color: AppColor.primaryColor,
            child: Text(
              "Choose from gallery",
              style: AppTextStyles.uploadImageTextStyle(),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              PickedFile pickImage =
                  await ImagePicker().getImage(source: ImageSource.camera);
              image = File(pickImage.path);
              Navigator.of(context).pop();
              final reference = _storage
                  .ref()
                  .child('${_firebaseAuth.currentUser.uid}mood post/');
              final uploadTask = reference.putFile(image);
              uploadTask.whenComplete(() async {
                imageUrl = await reference.getDownloadURL();
                print(imageUrl);
              });
              setState(() {
                isImage = true;
                pickFile = image;
              });
              AppConstantsWidgets.appToastDisplay(context,
                  info: "Image Uploaded!!");
            },
            color: AppColor.primaryColor,
            child: Text(
              "Camera",
              style: AppTextStyles.uploadImageTextStyle(),
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
      resizeToAvoidBottomPadding: false,
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
                            backgroundImage: NetworkImage(
                                    profileData['photoUrl']) ??
                                NetworkImage(AppConstantString.drawerImageUrl),
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
                              style: AppTextStyles.moodPostEmotionStyle(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  AppConstantsWidgets.basicDivider(),
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
                        style: AppTextStyles.moodpostTextFieldStyle(),
                        buildCounter: (context,
                                {currentLength, isFocused, maxLength}) =>
                            null,
                        decoration: AppTextStyles.moodPostDecoration(
                            "Write your Post...."),
                      ),
                    ),
                  ),
                  AppConstantsWidgets.basicDivider(),
                  Visibility(
                    visible: isImage,
                    child: Align(
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                            image: isImage
                                ? FileImage(pickFile)
                                : AssetImage('assets/userlogo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.camera_alt_outlined,
                          size: 40.0,
                          color: AppColor.primaryColor,
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
                                        decoration: AppTextStyles
                                            .moodPostSearchFeildDecoration(
                                                hint: "Search"),
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
                                              style: AppTextStyles
                                                  .moodpostParticularUserTileStyle(),
                                            ),
                                            trailing: Checkbox(
                                              onChanged: (data) {},
                                              value: false,
                                              activeColor:
                                                  AppColor.primaryColor,
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
                                                style: AppTextStyles
                                                    .moodPostParticularUserButtonStyle(),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
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
                                              color: AppColor.primaryColor,
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
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Choose who to share with',
                                  style: AppTextStyles.moodpostShareWithStyle(),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: () {
                              if (_postMessageController.text.isNotEmpty) {
                                try {
                                  BackendDBservices.sharePostData(
                                    postMessage: _postMessageController.text,
                                    emotion: moodTask.getMood(),
                                    name: profileData['name'],
                                    uid: _firebaseAuth.currentUser.uid,
                                  );
                                  _postMessageController.clear();
                                  AppConstantsWidgets.appToastDisplay(context,
                                      info: "Post Uploaded!!");
                                } catch (e) {
                                  AppConstantsWidgets.appToastDisplay(context,
                                      info: e.message);
                                }
                              } else {
                                AppConstantsWidgets.appToastDisplay(context,
                                    info: "Empty Post can't be Uploaded");
                              }
                            },
                            child: Text(
                              "Share",
                              style: AppTextStyles.moodPostShareBtnStyle(),
                            ),
                            color: AppColor.moodpostSharebtnColor,
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
                  backgroundColor: AppColor.circularProgressIndiColor,
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
