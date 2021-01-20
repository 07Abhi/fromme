import 'dart:io';
import 'package:fromme/backend_services/login_database.dart';
import 'package:fromme/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_strings.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:fromme/utilities/regexp_checker/app_regexp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfilePage extends StatefulWidget {
  static const String id = "/editprofile";

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
  bool isImage = false;
  // final _firebaseUser = FirebaseAuth.instance;

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
              final reference =
                  _storage.ref().child('${_auth.currentUser.uid}/');
              final uploadTask = reference.putFile(image);
              uploadTask.whenComplete(() async {
                imageUrl = await reference.getDownloadURL();
              });
              setState(() {
                isImage = true;
                pickFile = image;
              });
              AppConstantsWidgets.appToastDisplay(context,
                  info: "Image Uploaded Successfuly");
            },
            color: AppColor.uploadImageConatinerColor,
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
              final reference =
                  _storage.ref().child('${_auth.currentUser.uid}/');
              final uploadTask = reference.putFile(image);
              uploadTask.whenComplete(() async {
                imageUrl = await reference.getDownloadURL();
              });
              setState(() {
                isImage = true;
                pickFile = image;
              });
              AppConstantsWidgets.appToastDisplay(context,
                  info: "Image Uploaded Successfuly");
            },
            color: AppColor.uploadImageConatinerColor,
            child: Text(
              "Camera",
              style: AppTextStyles.uploadImageTextStyle(),
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
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.circularProgressIndiColor,
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
                              GestureDetector(
                                onTap: () {
                                  uploadImage(context);
                                },
                                child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: isImage
                                      ? FileImage(pickFile)
                                      : NetworkImage(AppConstantString
                                          .editProfilePhotoUrl),
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
                            style: AppTextStyles.editProfileHeadingStyle(),
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
                                style: AppTextStyles.loginOptionTextStyle(),
                                decoration:
                                    AppTextStyles.textFieldDecoration('Name'),
                                validator: (val) => val.isEmpty
                                    ? "Required"
                                    : RegExpsTester.nameCheck(val)
                                        ? null
                                        : "Error",
                              ),
                              Positioned(
                                right: 1.0,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 40.0,
                                  color: AppColor.editFieldIconColor,
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
                                    style: AppTextStyles.editGenderLableStyle(),
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
                                  style: AppTextStyles.logonformTextStyle(),
                                  decoration: AppTextStyles.textFieldDecoration(
                                      "Email"),
                                  validator: (val) => val.isEmpty
                                      ? "Required"
                                      : RegExpsTester.emailAddCheck(val)
                                          ? null
                                          : "Error",
                                ),
                                Positioned(
                                  right: 1.0,
                                  child: Icon(
                                    Icons.mail_outline,
                                    size: 40.0,
                                    color: AppColor.editFieldIconColor,
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
                                  style: AppTextStyles.logonformTextStyle(),
                                  decoration: AppTextStyles.textFieldDecoration(
                                      "Date of birth"),
                                  validator: (val) => val.isEmpty
                                      ? "Required"
                                      : RegExpsTester.dobChecker(val)
                                          ? null
                                          : "Error",
                                ),
                                Positioned(
                                  right: 1.0,
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    size: 40.0,
                                    color: AppColor.editFieldIconColor,
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
                                  style: AppTextStyles.logonformTextStyle(),
                                  decoration: AppTextStyles.textFieldDecoration(
                                      "Address"),
                                  validator: (val) => val.isEmpty
                                      ? "Required"
                                      : RegExpsTester.addressChecker(val)
                                          ? null
                                          : "Error",
                                ),
                                Positioned(
                                  right: 1.0,
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 40.0,
                                    color: AppColor.editFieldIconColor,
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
                          try {
                            BackendDBservices.saveEditProfileChanges(
                              name: _nameController.text,
                              gender: gender,
                              address: _addressController.text,
                              dob: _dobController.text,
                              availableStatus: true,
                              photoUrl: imageUrl,
                              uid: _auth.currentUser.uid,
                            );
                            _nameController.clear();
                            _emailController.clear();
                            _dobController.clear();
                            _addressController.clear();
                            AppConstantsWidgets.appToastDisplay(context,
                                info: "Profile Updated Succesfully!");

                            if (onRefreshProfile != null) {
                              onRefreshProfile();
                            }
                          } catch (e) {
                            AppConstantsWidgets.appToastDisplay(context,
                                info: e.message);
                          }
                        }
                      },
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            "Update",
                            style: AppTextStyles.btnTextStyle(),
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
  selectRadioOption(String val, String label) {
    return Row(
      children: [
        Radio(
          value: val,
          groupValue: gender,
          onChanged: (String val) {
            setState(() {
              gender = val;
            });
          },
          activeColor: AppColor.primaryColor,
          splashRadius: 10.0,
        ),
        Text(
          label,
          style: AppTextStyles.editProfileRadioStyle(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        selectRadioOption("Male", "Male"),
        selectRadioOption("Female", "Famale"),
        selectRadioOption("Others", "Others"),
      ],
    );
  }
}
