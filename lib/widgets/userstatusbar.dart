import 'package:flutter/material.dart';
import 'package:fromme/models/statusmodel.dart';
import 'package:fromme/utilities/app_colors.dart';

Widget userCircles(StatusModel data) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CircleAvatar(
          radius: 45.0,
          backgroundImage: NetworkImage(data.photoUrl),
        ),
      ),
      Positioned(
        right: 5.0,
        bottom: 6.0,
        child: CircleAvatar(
          radius: 12.0,
          child: CircleAvatar(
            radius: 10.0,
            backgroundColor: data.isOnline
                ? AppColor.onlineIndicator
                : AppColor.offlineIndicator,
          ),
        ),
      )
    ],
  );
}

Widget userStatusBar(BuildContext context, List<StatusModel> userData) {
  return Container(
    height: 100.0,
    width: MediaQuery.of(context).size.width,
    color: AppColor.userStatusBarColor,
    child: ListView.builder(
      itemBuilder: (context, index) => userCircles(userData[index]),
      itemCount: userData.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
    ),
  );
}
