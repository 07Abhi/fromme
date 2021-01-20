import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/backend_services/login_database.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class ChangeNumber extends StatefulWidget {
  static const String id = "/changeNumber";

  @override
  _ChangeNumberState createState() => _ChangeNumberState();
}

class _ChangeNumberState extends State<ChangeNumber> {
  TextEditingController _mobileController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Mobile No.',
                style: AppTextStyles.settingPageHeadingStyle(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  decoration: AppTextStyles.settingChangeMobileDecoration(
                      context, _mobileController, "Mobile No."),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ButtonTheme(
                    height: 50.0,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    child: FlatButton(
                      child: Text(
                        "Submit",
                        style: AppTextStyles.btnTextStyle(),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        try {
                          await BackendDBservices.updateUserMobileNumber(
                              _mobileController.text,
                              uid: _auth.currentUser.uid);
                          SystemChannels.textInput
                              .invokeMethod("TextInput.hide");
                          _mobileController.clear();
                          AppConstantsWidgets.appToastDisplay(context,
                              info: "Change Request Sent");
                        } catch (e) {
                          AppConstantsWidgets.appToastDisplay(context,
                              info: e.message);
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
