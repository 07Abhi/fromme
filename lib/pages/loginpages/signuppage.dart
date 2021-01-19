import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fromme/backend_services/login_database.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:fromme/utilities/regexp_checker/app_regexp.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "/signUpPage";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _authSignUp = FirebaseAuth.instance;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _confpassController = new TextEditingController();
  bool _tncCheck = false;
  bool _hidePassword = true;

  //Obsecure password
  void _showPass() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  //For changing the checkBox
  void _checkbox(bool data) {
    setState(() {
      _tncCheck = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppConstantsWidgets.fixedAppBar(context),
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
                      style: AppTextStyles.appPagesHeading(),
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
                            style: AppTextStyles.logonformTextStyle(),
                            decoration:
                                AppTextStyles.textFieldDecoration("Name"),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : RegExpsTester.nameCheck(val)
                                    ? null
                                    : "Incorrect Format",
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
                            style: AppTextStyles.logonformTextStyle(),
                            decoration:
                                AppTextStyles.textFieldDecoration("Mobile"),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : RegExpsTester.mobileCheck(val)
                                    ? null
                                    : "Incorrect Phone Number",
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
                            style: AppTextStyles.logonformTextStyle(),
                            decoration:
                                AppTextStyles.textFieldDecoration('Email'),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : RegExpsTester.emailAddCheck(val)
                                    ? null
                                    : "Wrong email format",
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
                                style: AppTextStyles.logonformTextStyle(),
                                decoration: AppTextStyles.textFieldDecoration(
                                    'Password'),
                                validator: (val) => val.isEmpty
                                    ? "Required"
                                    : RegExpsTester.passCheck(val)
                                        ? null
                                        : "One Capital Character, Numeral and length above 8",
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
                                      color: AppColor.showpasswordColor,
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
                            style: AppTextStyles.logonformTextStyle(),
                            decoration: AppTextStyles.textFieldDecoration(
                                'Confirm Password'),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : RegExpsTester.passCheck(val)
                                    ? null
                                    : "One Capital Character, Numeral and length above 8",
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
                        activeColor: AppColor.checkBoxActiveColor,
                        value: _tncCheck,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to ",
                              style: AppTextStyles.appTandCTextStyles(),
                            ),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: AppTextStyles.bottomInfoTextStyle(),
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
                                  final registerUser =
                                      BackendDBservices.createNewUser(
                                          email: _emailController.text,
                                          password: _passController.text);
                                  if (registerUser != null) {
                                    try {
                                      await BackendDBservices.saveSignUpData(
                                        uid: _authSignUp.currentUser.uid,
                                        name: _nameController.text,
                                        mobile: _mobileController.text,
                                        email: _emailController.text,
                                      );
                                      _nameController.clear();
                                      _mobileController.clear();
                                      _emailController.clear();
                                      _passController.clear();
                                      _confpassController.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        AppConstantsWidgets.appGeneralSanckbar(
                                            message: "Sign Up Succesfully!!!"),
                                      );
                                      Navigator.pop(context);
                                    } catch (e) {
                                      AppConstantsWidgets.appToastDisplay(
                                          context,
                                          info: "Unable to register user");
                                    }
                                  }
                                } catch (e) {
                                  AppConstantsWidgets.appToastDisplay(context,
                                      info: "Some error ocurred");
                                }
                              } else {
                                AppConstantsWidgets.appToastDisplay(context,
                                    info: "Accept terms & conditions");
                              }
                            } else {
                              AppConstantsWidgets.appToastDisplay(context,
                                  info: "Password not matching!!");
                            }
                          }
                        },
                        color: AppColor.appLoginButtons,
                        child: Text(
                          "Sign Up",
                          style: AppTextStyles.btnTextStyle(),
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
                        style: AppTextStyles.bottomSecondTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          " Click Here",
                          style: AppTextStyles.bottomSecondHighlightTextStyle(),
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
