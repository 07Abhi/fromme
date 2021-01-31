import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fromme/backend_services/login_database.dart';
import 'package:fromme/pages/navigation_pages/homepage.dart';
import 'package:fromme/utilities/app_animation_routes.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_login_provider.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:fromme/utilities/regexp_checker/app_regexp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String id = "/loginPage";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map userProfile;
  // FirebaseMessaging _messaging = FirebaseMessaging();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email'], hostedDomain: '', clientId: '');
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwodController = new TextEditingController();
  bool _hidePassword = true;
  bool _isAuth = false;
  String token;
  //For password show and hide
  void _showPass() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  final formKey = GlobalKey<FormState>();
  getLoginData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _isAuth = pref.getBool('isLogged') ?? false;
    });
  }

  // generateTokenForNotification() async {
  //   String data = await _messaging.getToken();
  //   setState(() {
  //     token = data;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // generateTokenForNotification();
    getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return _isAuth
        ? HomePage()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "FromMe",
                      style: AppTextStyles.appBarTitleStyle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        "Login",
                        style: AppTextStyles.appPagesHeading(),
                      ),
                    ),
                    SizedBox(
                      height: 22.00,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
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
                                AppTextStyles.textFieldDecoration("Email"),
                            validator: (val) => val.isEmpty
                                ? "Required"
                                : RegExpsTester.emailAddCheck(val)
                                    ? null
                                    : "Error",
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              TextFormField(
                                controller: _passwodController,
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
                                        : "Error",
                              ),
                              Positioned(
                                right: 1.0,
                                bottom: 3.0,
                                child: FlatButton(
                                  onPressed: _showPass,
                                  color: Colors.white,
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: ButtonTheme(
                        height: 50.0,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: FlatButton(
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwodController.text);
                                BackendDBservices.updateTokenAtLogin(
                                    _auth.currentUser.uid, token);
                                setState(() {
                                  _isAuth = true;
                                });
                                AppConstantsWidgets.setLoginPrefference(
                                    _isAuth);
                                Navigator.pushReplacement(
                                    context,
                                    AnimationRouting.homeUpPageAnimation(
                                        null, null, _auth));
                                AppConstantsWidgets.appToastDisplay(context,
                                    info: "Welcome");
                                _emailController.clear();
                                _passwodController.clear();
                              } catch (e) {
                                AppConstantsWidgets.appToastDisplay(context,
                                    info: e.message);
                              }
                            }
                          },
                          color: AppColor.appLoginButtons,
                          child: Text(
                            "Log In",
                            style: AppTextStyles.btnTextStyle(),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context, AnimationRouting.signUpPageAnimation()),
                      child: Text(
                        "Create New Accout",
                        style: AppTextStyles.bottomSecondHighlightTextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forget Passsword?",
                            style: AppTextStyles.bottomSecondTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              AnimationRouting.forgetPasswordPageAnimation(),
                            ),
                            child: Text(
                              " Click Here",
                              style: AppTextStyles
                                  .bottomSecondHighlightTextStyle(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OR",
                      style: AppTextStyles.loginOptionTextStyle(),
                    ),
                    //Google SignUp
                    SignInButton(
                      Buttons.GoogleDark,
                      onPressed: () async {
                        await LoginProvider.signUpWithGoogle(context,
                            googleSignIn: _googleSignIn, auth: _auth);
                        Navigator.pushReplacement(
                            context,
                            AnimationRouting.homeUpPageAnimation(
                                null, _googleSignIn, _auth));
                        setState(() {
                          _isAuth = true;
                        });
                        AppConstantsWidgets.setLoginPrefference(_isAuth);
                        AppConstantsWidgets.appToastDisplay(context,
                            info: "Welcome");
                        BackendDBservices.saveGoogleSignUpData(
                            _googleSignIn, _auth);
                      },
                    ),
                    SignInButton(
                      Buttons.FacebookNew,
                      onPressed: () async {
                        final data = await LoginProvider.signUpWithFacebook(
                            context, _facebookLogin, _auth);
                        setState(() {
                          userProfile = data;
                        });
                        Navigator.pushReplacement(
                            context,
                            AnimationRouting.homeUpPageAnimation(
                                _facebookLogin, null, _auth));
                        setState(() {
                          _isAuth = true;
                        });
                        AppConstantsWidgets.setLoginPrefference(_isAuth);
                        AppConstantsWidgets.appToastDisplay(context,
                            info: "Welcome");
                        BackendDBservices.saveFacebookSignUpData(
                            userProfile, _auth);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
