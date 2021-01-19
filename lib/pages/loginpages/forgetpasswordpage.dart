import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:fromme/utilities/regexp_checker/app_regexp.dart';
import 'package:toast/toast.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const String id = "/forgetpass";
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "Forget Password",
                  style: AppTextStyles.appPagesHeading(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.white,
                child: Text(
                  "Don't worry Resetting your password is easy, just tell us the email address registered with fromMe",
                  style: AppTextStyles.forgetPassInfoStyle(),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  maxLength: 50,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyles.loginOptionTextStyle(),
                  decoration:
                      AppTextStyles.textFieldDecoration("Registered Email"),
                  validator: (val) => val.isEmpty
                      ? "Required"
                      : RegExpsTester.emailAddCheck(val)
                          ? null
                          : "Enter Correct Mail",
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              ButtonTheme(
                height: 50.0,
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      try {
                        await _firebaseAuth.sendPasswordResetEmail(
                            email: _emailController.text);
                        Navigator.of(context).pop(true);
                        AppConstantsWidgets.appToastDisplay(context,
                            info: "Reset Link has sent");
                      } catch (e) {
                        AppConstantsWidgets.appToastDisplay(context,
                            info: e.message);
                      }
                    }
                  },
                  color: Colors.cyan.shade400,
                  child: Text(
                    "Submit",
                    style: AppTextStyles.btnTextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
