import 'package:flutter/material.dart';

Widget userCircles() {
  return Stack(
    alignment: Alignment.center,
    children: [
      CircleAvatar(
        radius: 45.0,
        backgroundImage: AssetImage('assets/userlogo.png'),
      ),
      Positioned(
        right: 5.0,
        bottom: 6.0,
        child: CircleAvatar(
          radius: 12.0,
          child: CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.green,
          ),
        ),
      )
    ],
  );
}

Widget userStatusBar(BuildContext context) {
  return Container(
    height: 100.0,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: userCircles(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: userCircles(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: userCircles(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: userCircles(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: userCircles(),
        ),
      ],
    ),
  );
}
