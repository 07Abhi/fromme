import 'package:flutter/material.dart';

Widget chatTiles(BuildContext context, String imgUrl, String name) {
  return Container(
    height: 100.0,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CircleAvatar(
            radius: 45.0,
            backgroundImage: AssetImage(imgUrl),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Message",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Time/Date",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    ),
  );
}
