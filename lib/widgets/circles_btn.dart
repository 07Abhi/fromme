import 'package:flutter/material.dart';
import 'package:fromme/widgets/circles.dart';

circlesWidget() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Positioned(
        left: 1.0,
        top: 12.0,
        child: Circles(
          height: 18.0,
          width: 18.0,
        ),
      ),
      Positioned(
        bottom: 4.0,
        left: 5.0,
        child: Circles(
          height: 16.0,
          width: 16.0,
        ),
      ),
      Positioned(
        left: 22.0,
        child: Circles(
          height: 22.0,
          width: 22.0,
        ),
      ),
    ],
  );
}
