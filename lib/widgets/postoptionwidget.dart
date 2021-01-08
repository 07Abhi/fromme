import 'package:flutter/material.dart';

class PostOptWidget extends StatelessWidget {
  final Color colors;
  final String txt;
  PostOptWidget({this.colors, this.txt});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40.0,
      backgroundColor: colors,
      child: CircleAvatar(
        radius: 39.0,
        backgroundColor: Colors.white,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              color: colors,
            ),
          ),
        ),
      ),
    );
  }
}
