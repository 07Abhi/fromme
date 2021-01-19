import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider {
  static loginWithCredentials({String email, String password}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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
}
