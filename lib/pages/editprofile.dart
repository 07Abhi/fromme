import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfilePage extends StatefulWidget {
  static const String id = "/editprofile";
  String profileId;
  EditProfilePage({this.profileId});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

String gender = "Male";

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  File pickFile;
  String imageUrl;
  bool isLoading = false;
  DocumentSnapshot userdata;
  // final _firebaseUser = FirebaseAuth.instance;

  bool _nameChecker(String data) {
    RegExp pattern = new RegExp(r'[a-zA-z ]{4,25}');
    return pattern.hasMatch(data);
  }

  bool _emailAddCheck(String data) {
    RegExp pattern = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return pattern.hasMatch(data);
  }

  bool _dobChecker(String data) {
    RegExp pattern = new RegExp(r'[0-9/-]{8,}');
    return pattern.hasMatch(data);
  }

  bool _addressChecker(String data) {
    RegExp pattern = new RegExp(r'[0-9a-zA-Z ,/-]{15,50}');
    return pattern.hasMatch(data);
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
              print("user's uid: ${_auth.currentUser.uid}");
              PickedFile pickImage =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              image = File(pickImage.path);
              Navigator.of(context).pop();
              final reference =
                  _storage.ref().child('${_auth.currentUser.uid}/');
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
              final reference =
                  _storage.ref().child('${_auth.currentUser.displayName}/');
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

  getUserInfo() async {
    setState(() {
      isLoading = true;
    });
    userdata = await _firestore
        .collection('userdata')
        .doc(_auth.currentUser.uid)
        .get();
    if (userdata != null) {
      _nameController.text = userdata['name'];
      _dobController.text = userdata['dob'];
      _emailController.text = userdata['email'];
      _addressController.text = userdata['address'];
    } else {
      _nameController.text = "";
      _dobController.text = "";
      _emailController.text = "";
      _addressController.text = "";
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    String dataId = ModalRoute.of(context).settings.arguments;
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white54,
                strokeWidth: 5.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
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
                                backgroundColor: Colors.blue.shade200,
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(Icons.camera),
                                    onPressed: () {
                                      uploadImage(context);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                controller: _nameController,
                                maxLength: 25,
                                buildCounter: (BuildContext context,
                                        {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                    null,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                  focusColor: Colors.grey.shade400,
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                validator: (val) => val.isEmpty
                                    ? "Required"
                                    : _nameChecker(val)
                                        ? null
                                        : "Error",
                              ),
                              Positioned(
                                right: 1.0,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 40.0,
                                  color: Color(0XFFAAAAAA),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Container(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  RadioTile()
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  maxLength: 50,
                                  keyboardType: TextInputType.emailAddress,
                                  buildCounter: (BuildContext context,
                                          {int currentLength,
                                          int maxLength,
                                          bool isFocused}) =>
                                      null,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    focusColor: Colors.grey.shade400,
                                    labelText: "Email Address",
                                    labelStyle: TextStyle(
                                      color: Colors.cyan,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  validator: (val) => val.isEmpty
                                      ? "Required"
                                      : _emailAddCheck(val)
                                          ? null
                                          : "Error",
                                ),
                                Positioned(
                                  right: 1.0,
                                  child: Icon(
                                    Icons.mail_outline,
                                    size: 40.0,
                                    color: Color(0XFFAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TextFormField(
                                  controller: _dobController,
                                  maxLength: 10,
                                  keyboardType: TextInputType.datetime,
                                  buildCounter: (BuildContext context,
                                          {int currentLength,
                                          int maxLength,
                                          bool isFocused}) =>
                                      null,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    focusColor: Colors.grey.shade400,
                                    labelText: "Date of Birth",
                                    labelStyle: TextStyle(
                                      color: Colors.cyan,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  validator: (val) => val.isEmpty
                                      ? "Required"
                                      : _dobChecker(val)
                                          ? null
                                          : "Error",
                                ),
                                Positioned(
                                  right: 1.0,
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    size: 40.0,
                                    color: Color(0XFFAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TextFormField(
                                  controller: _addressController,
                                  maxLength: 50,
                                  maxLines: 3,
                                  keyboardType: TextInputType.streetAddress,
                                  buildCounter: (BuildContext context,
                                          {int currentLength,
                                          int maxLength,
                                          bool isFocused}) =>
                                      null,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    focusColor: Colors.grey.shade400,
                                    labelText: "Address",
                                    labelStyle: TextStyle(
                                      color: Colors.cyan,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  validator: (val) => val.isEmpty
                                      ? "Required"
                                      : _addressChecker(val)
                                          ? null
                                          : "Error",
                                ),
                                Positioned(
                                  right: 1.0,
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 40.0,
                                    color: Color(0XFFAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          print('Here comes teh data Id $dataId');
                          _firestore
                              .collection('userdata')
                              .doc(_auth.currentUser.uid)
                              .update({
                            'name': _nameController.text,
                            'gender': gender,
                            'address': _addressController.text,
                            'dob': _dobController.text,
                            'availableStatus': true,
                            'photoUrl': imageUrl,
                          }).then((value) {
                            _nameController.clear();
                            _emailController.clear();
                            _dobController.clear();
                            _addressController.clear();
                            Toast.show(
                              "Profile Updated Successfully",
                              context,
                              duration: 2,
                              gravity: Toast.BOTTOM,
                              backgroundColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                            );
                          }).catchError((error) {
                            Toast.show(
                              'error is occurred',
                              context,
                              duration: 2,
                              gravity: Toast.BOTTOM,
                              backgroundColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                            );
                          });
                        }
                      },
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class RadioTile extends StatefulWidget {
  @override
  _RadioTileState createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Radio(
              value: "Male",
              groupValue: gender,
              onChanged: (String val) {
                setState(() {
                  gender = val;
                });
              },
              activeColor: Theme.of(context).primaryColor,
              splashRadius: 10.0,
            ),
            Text(
              "Male",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xffAAAAAA),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: "Female",
              groupValue: gender,
              onChanged: (String val) {
                setState(() {
                  gender = val;
                });
              },
              activeColor: Theme.of(context).primaryColor,
              splashRadius: 10.0,
            ),
            Text(
              "Female",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xffAAAAAA),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: "Others",
              groupValue: gender,
              onChanged: (String val) {
                setState(() {
                  gender = val;
                });
              },
              activeColor: Theme.of(context).primaryColor,
              splashRadius: 10.0,
            ),
            Text(
              "Others",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xffAAAAAA),
              ),
            ),
          ],
        )
      ],
    );
  }
}
