import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  static const String id = "/contactpage";
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    print("hello world");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Contact Page"),
      ),
    );
  }
}
