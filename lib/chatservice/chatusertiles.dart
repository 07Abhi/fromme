import 'package:flutter/material.dart';

Widget chatUserTiles(BuildContext context, String imgUrl, String name) {
  return Container(
    height: 100.0,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(imgUrl),
          ),
        ),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
