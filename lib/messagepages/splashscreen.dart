import 'package:flutter/material.dart';
import 'package:fromme/loginpages/loginpage.dart';

class SplashPage extends StatefulWidget {
  static const String id = "/splashPage";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, LoginPage.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "FromMe",
            style: TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.w500,
              color: Colors.cyan.shade400,
              fontFamily: "LovedByTheKing",
            ),
          ),
        ),
      ),
    );
  }
}
