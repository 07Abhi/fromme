import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "/signUpPage";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _authSignUp = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _confpassController = new TextEditingController();
  bool _tncCheck = false;
  bool _hidePassword = true;
  void _showPass() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  bool _nameCheck(String data) {
    RegExp pattern = new RegExp(r'[A-Za-z]{3,}');
    return pattern.hasMatch(data);
  }

  bool _mobileCheck(String data) {
    RegExp pattern = new RegExp(r'^(?:[0])?[0-9]{10}');
    return pattern.hasMatch(data);
  }

  bool _emailAddCheck(String data) {
    RegExp pattern = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return pattern.hasMatch(data);
  }

  bool _passCheck(String data) {
    RegExp pattern = new RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return pattern.hasMatch(data);
  }

  void _checkbox(bool data) {
    setState(() {
      _tncCheck = data;
    });
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _nameController,
                            maxLength: 25,
                            buildCounter: (BuildContext context,
                                    {int currentLength,
                                    int maxLength,
                                    bool isFocused}) =>
                                null,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.grey.shade400,
                              labelText: "Name*",
                              labelStyle: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : _nameCheck(val)
                                    ? null
                                    : "Error",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _mobileController,
                            maxLength: 11,
                            buildCounter: (BuildContext context,
                                    {int currentLength,
                                    int maxLength,
                                    bool isFocused}) =>
                                null,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.grey.shade400,
                              labelText: "Mobile*",
                              labelStyle: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : _mobileCheck(val)
                                    ? null
                                    : "Error",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            maxLength: 50,
                            buildCounter: (BuildContext context,
                                    {int currentLength,
                                    int maxLength,
                                    bool isFocused}) =>
                                null,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.grey.shade400,
                              labelText: "Email*",
                              labelStyle: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : _emailAddCheck(val)
                                    ? null
                                    : "Error",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              TextFormField(
                                controller: _passController,
                                textInputAction: TextInputAction.next,
                                maxLength: 20,
                                buildCounter: (BuildContext context,
                                        {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                    null,
                                keyboardType: TextInputType.text,
                                obscuringCharacter: "*",
                                obscureText: _hidePassword,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                  focusColor: Colors.grey.shade400,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                validator: (val) => val.isEmpty
                                    ? "Required"
                                    : _passCheck(val)
                                        ? null
                                        : "Error",
                              ),
                              Positioned(
                                right: 1.0,
                                bottom: 3.0,
                                child: FlatButton(
                                  color: Colors.white,
                                  onPressed: _showPass,
                                  child: Text(
                                    _hidePassword ? "show" : "hide",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            controller: _confpassController,
                            maxLength: 20,
                            buildCounter: (BuildContext context,
                                    {int currentLength,
                                    int maxLength,
                                    bool isFocused}) =>
                                null,
                            obscuringCharacter: "*",
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.grey.shade400,
                              labelText: "Confirm Password*",
                              labelStyle: TextStyle(
                                color: Colors.cyan,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : _passCheck(val)
                                    ? null
                                    : "Error",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        onChanged: _checkbox,
                        activeColor: Colors.cyan.shade300,
                        value: _tncCheck,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87),
                            ),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.cyan.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ButtonTheme(
                      height: 50.0,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (_passController.text ==
                                _confpassController.text) {
                              if (_tncCheck) {
                                try {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');

                                  final registerUser = await _authSignUp
                                      .createUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _confpassController.text);

                                  if (registerUser != null) {
                                    try {
                                      await _firestore
                                          .collection('userdata')
                                          .doc(_authSignUp.currentUser.uid)
                                          .set({
                                        "name": _nameController.text,
                                        "mobile": _mobileController.text,
                                        "email": _emailController.text,
                                        "photoUrl": null,
                                        "address": null,
                                        "availableStatus": null,
                                        "gender": null,
                                        "dob": null,
                                      });
                                      _nameController.clear();
                                      _mobileController.clear();
                                      _emailController.clear();
                                      _passController.clear();
                                      _confpassController.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("SignUp successfully!!"),
                                          backgroundColor: Colors.cyan.shade300,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    } catch (e) {
                                      print("Enable to register the user!!!");
                                    }
                                  }
                                } catch (e) {
                                  print("Enable to login from catch side");
                                  Toast.show("Some error Occurred!!!!", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      textColor: Colors.white);
                                }
                              } else {
                                Toast.show("Agree Term and Conditions", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    textColor: Colors.white);
                              }
                            } else {
                              Toast.show("Password not matching", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  textColor: Colors.white);
                            }
                          }
                        },
                        color: Colors.cyan.shade400,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Registered",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          " Click Here",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.cyan.shade400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
