import 'package:flutter/material.dart';
import 'package:fromme/utilities/app_colors.dart';

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
            color: AppColor.circleWidShadowColor1,
          ),
          BoxShadow(
            offset: Offset(0.0, -3.0),
            blurRadius: 2.0,
            color: AppColor.circleWidShadowColor2,
          ),
        ],
      ),
    );
  }
}
