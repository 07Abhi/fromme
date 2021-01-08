import 'package:flutter/material.dart';

class Circles extends StatelessWidget {
  final double height;
  final double width;
  Circles({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 3.0),
            blurRadius: 2.0,
            color: Color(0xff2DC4D9),
          ),
          BoxShadow(
            offset: Offset(0.0, -3.0),
            blurRadius: 2.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
