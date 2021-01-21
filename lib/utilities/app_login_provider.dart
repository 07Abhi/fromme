import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fromme/pages/loginpages/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider {
  static loginWithCredentials(FirebaseAuth auth,
      {String email, String password}) {
    auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signUpWithGoogle(BuildContext context,
      {GoogleSignIn googleSignIn, FirebaseAuth auth}) async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final User user = (await auth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      AppConstantsWidgets.appToastDisplay(context, info: e.message);
      return null;
    }
  }

  // ignore: missing_return
  static Future<Map> signUpWithFacebook(BuildContext context,
      FacebookLogin facebookLogin, FirebaseAuth auth) async {
    try {
      final result = await facebookLogin.logIn(['email']);
      final token = result.accessToken.token;
      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(token);
        final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token',
        );
        final profile = json.jsonDecode(graphResponse.body);
        if (result.status == FacebookLoginStatus.loggedIn) {
          auth.signInWithCredential(credential);
          return profile;
        } else {
          AppConstantsWidgets.appToastDisplay(context, info: "Unable to Login");
          return null;
        }
      }
    } catch (e) {
      AppConstantsWidgets.appToastDisplay(context, info: e.message);
      return null;
    }
  }

  static makeUserOnline(String uid) async {
    FirebaseFirestore.instance.collection('userdata').doc(uid).update({
      "isOnline": true,
    });
  }

  static makeUserOffline(String uid) async {
    FirebaseFirestore.instance.collection('userdata').doc(uid).update({
      "isOnline": false,
    });
  }

  static Future<void> signOut(BuildContext context, FacebookLogin faceBookData,
      GoogleSignIn googleData, FirebaseAuth firebaseAuth) async {
    if (faceBookData != null) {
      await faceBookData.logOut();
      firebaseAuth.signOut();
      LoginProvider.makeUserOffline(FirebaseAuth.instance.currentUser.uid);
      Navigator.pushReplacementNamed(context, LoginPage.id);
      AppConstantsWidgets.appToastDisplay(context,
          info: "Logout Succesfully!!");
    } else if (googleData != null) {
      await googleData.signOut();
      firebaseAuth.signOut();
      LoginProvider.makeUserOnline(FirebaseAuth.instance.currentUser.uid);
      Navigator.pushReplacementNamed(context, LoginPage.id);
      AppConstantsWidgets.appToastDisplay(context,
          info: "Logout Succesfully!!");
    } else {
      if (firebaseAuth != null) {
        firebaseAuth.signOut();
      } else {
        FirebaseAuth.instance.signOut();
      }
      LoginProvider.makeUserOffline(FirebaseAuth.instance.currentUser.uid);
      Navigator.pushReplacementNamed(context, LoginPage.id);
      AppConstantsWidgets.appToastDisplay(context,
          info: "Logout Succesfully!!");
    }
  }
}
