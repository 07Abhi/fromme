import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shadowColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              size: 40.0,
              color: Colors.black87,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "FromMe",
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.w600,
              color: Colors.cyan,
              fontFamily: "LovedByTheKing",
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87),
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
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
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
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    focusColor: Colors.grey.shade400,
                    hintText: "Regiestered Email",
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.cyan,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
                        Toast.show(
                            "Reset mail sent to registered email", context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: Colors.white);
                      } catch (e) {
                        Toast.show(e.message, context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: Colors.white);
                      }
                    }
                  },
                  color: Colors.cyan.shade400,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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
