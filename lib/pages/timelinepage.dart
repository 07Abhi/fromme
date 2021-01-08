import 'package:flutter/material.dart';

class TimeLinePage extends StatefulWidget {
  static const String id = "/timelinepage";
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("TimeLine Page"),
      ),
    );
  }
}
