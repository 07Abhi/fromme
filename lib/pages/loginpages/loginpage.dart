import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fromme/pages/loginpages/forgetpasswordpage.dart';
import 'package:fromme/pages/loginpages/signuppage.dart';
import 'package:fromme/pages/navigation_pages/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:toast/toast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String id = "/loginPage";
  @override
  _LoginPageState createState() => _LoginPageState();
}

// bool _codeCheck(String data) {
//   RegExp pattern = new RegExp(r'[+|0-9]{3}');
//   return pattern.hasMatch(data);
// }

// bool _mobileCheck(String data) {
//   RegExp pattern = new RegExp(r'^(?:[0])?[0-9]{10}');
//   return pattern.hasMatch(data);
// }
Route _homeUpPageAnimation(
    FacebookLogin fbData, GoogleSignIn googleData, FirebaseAuth firebaseData) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomePage(
      faceBookData: fbData,
      googleData: googleData,
      firebaseAuth: firebaseData,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.5);
      var end = Offset.zero;
      var curve = Curves.easeInCubic;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Route _signUpPageAnimation() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.5);
      var end = Offset.zero;
      var curve = Curves.bounceOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Route _forgetPasswordPageAnimation() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ForgetPasswordPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.bounceInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
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

class _LoginPageState extends State<LoginPage> {
  Map userProflie;
  final _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email'], hostedDomain: '', clientId: '');
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwodController = new TextEditingController();
  bool _hidePassword = true;
  bool _isAuth = false;
  //For password show and hide
  void _showPass() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final User user = (await _auth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      print(e.message);
      Toast.show(
        e.message,
        context,
        duration: 2,
        gravity: Toast.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.grey.shade400,
      );
    }
  }

  Future<void> signUpWithFacebook() async {
    try {
      final result = await _facebookLogin.logIn(['email']);
      final token = result.accessToken.token;
      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(token);
        final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token',
        );
        final profile = json.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProflie = profile;
        });
        if (result.status == FacebookLoginStatus.loggedIn) {
          _auth.signInWithCredential(credential);
        } else {
          print("notAuthorized");
        }
      }
    } catch (e) {
      print(e.message);
    }
  }

  final formKey = GlobalKey<FormState>();
  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _isAuth = pref.getBool('isLogged') ?? false;
    });
  }

  // persistFirebase() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {

  //       });
  // }

  @override
  void initState() {
    super.initState();
    getData();
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
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.cyan,
                        fontFamily: "LovedByTheKing",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 22.05,
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
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.grey.shade400,
                              labelText: "Email",
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
                                  onPressed: _showPass,
                                  color: Colors.white,
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
                                setState(() {
                                  _isAuth = true;
                                });
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setBool('isLogged', _isAuth);

                                Navigator.pushReplacement(context,
                                    _homeUpPageAnimation(null, null, _auth));
                                Toast.show(
                                  "Welcome",
                                  context,
                                  duration: 1,
                                  gravity: 0,
                                  textColor: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                );
                                _emailController.clear();
                                _passwodController.clear();
                              } catch (e) {
                                Toast.show(
                                  e.message,
                                  context,
                                  duration: 3,
                                  gravity: 0,
                                  textColor: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                );
                              }
                            }
                          },
                          color: Colors.cyan.shade400,
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.push(context, _signUpPageAnimation()),
                      child: Text(
                        "Create New Accout",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.cyan.shade500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forget Passsword?",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context, _forgetPasswordPageAnimation()),
                            child: Text(
                              " Click Here",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.cyan.shade400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                    SignInButton(
                      Buttons.GoogleDark,
                      onPressed: () async {
                        await signUpWithGoogle();
                        Navigator.pushReplacement(context,
                            _homeUpPageAnimation(null, _googleSignIn, _auth));
                        setState(() {
                          _isAuth = true;
                        });
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('isLogged', _isAuth);
                        Toast.show(
                          "Welcome",
                          context,
                          duration: 2,
                          gravity: 0,
                          textColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                        );
                        _firestore
                            .collection("userdata")
                            .doc(_googleSignIn.currentUser.id)
                            .set({
                          "address": null,
                          "availableStatus": true,
                          "email": _googleSignIn.currentUser.email,
                          "gender": null,
                          "isOnline": false,
                          "mobile": null,
                          "name": _googleSignIn.currentUser.displayName,
                          "photoUrl": _googleSignIn.currentUser.photoUrl,
                          "uid": _googleSignIn.currentUser.id
                        });
                      },
                    ),
                    SignInButton(
                      Buttons.FacebookNew,
                      onPressed: () async {
                        await signUpWithFacebook();
                        Navigator.pushReplacement(context,
                            _homeUpPageAnimation(_facebookLogin, null, _auth));
                        setState(() {
                          _isAuth = true;
                        });
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('isLogged', _isAuth);
                        Toast.show(
                          "Welcome",
                          context,
                          duration: 1,
                          gravity: 0,
                          textColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                        );
                        _firestore
                            .collection('userdata')
                            .doc(userProflie['id'])
                            .set({
                          'address': null,
                          'availableStatus': true,
                          'dob': null,
                          'email': userProflie['email'],
                          'gender': null,
                          'isOnline': true,
                          'mobile': null,
                          'name': userProflie['name'],
                          'photoUrl': null,
                          'uid': userProflie['id']
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
