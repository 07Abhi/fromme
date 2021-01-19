import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fromme/pages/loginpages/forgetpasswordpage.dart';
import 'package:fromme/pages/loginpages/signuppage.dart';
import 'package:fromme/pages/navigation_pages/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AnimationRouting {
  static Route homeUpPageAnimation(FacebookLogin fbData,
      GoogleSignIn googleData, FirebaseAuth firebaseData) {
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
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static Route signUpPageAnimation() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.5);
        var end = Offset.zero;
        var curve = Curves.bounceOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static Route forgetPasswordPageAnimation() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ForgetPasswordPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.bounceInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
