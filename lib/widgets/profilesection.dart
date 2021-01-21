import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/backend_services/login_database.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_strings.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

Widget profileSection(
  BuildContext context,
  FirebaseFirestore firestoreAcces,
  FirebaseAuth user, {
  String email,
  bool availableStatus,
  String gender,
  String dob,
  String mobile,
  String address,
  String photoUrl,
  String name,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(photoUrl) ??
                        NetworkImage(AppConstantString.drawerImageUrl),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.profilePageNameStyle(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Profile Details',
                style: AppTextStyles.profilePageHeadingStyle(),
              )
            ],
          ),
        ),
      ),
      AppConstantsWidgets.basicDivider(),
      ListTile(
        leading: Icon(
          Icons.mail_outline,
          size: 30.0,
          color: AppColor.profilePagelabelIconColor,
        ),
        title: Text(
          email,
          style: AppTextStyles.profilePageLabelsStyle(),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.trip_origin_outlined,
          size: 30.0,
          color: AppColor.profilePagelabelIconColor,
        ),
        title: Text(
          "Availablity Status",
          style: AppTextStyles.profilePageLabelsStyle(),
        ),
        trailing: Switch(
          value: availableStatus,
          onChanged: (val) {
            BackendDBservices.changeAvailableStatus(
              uid: user.currentUser.uid,
              status: val,
            );
          },
          activeColor: AppColor.primaryColor,
          activeTrackColor: AppColor.profilePageAvailableBtnActiveTrack,
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.wc,
          size: 30.0,
          color: AppColor.profilePagelabelIconColor,
        ),
        title: Text(
          gender,
          style: AppTextStyles.profilePageLabelsStyle(),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          size: 30.0,
          color: AppColor.profilePagelabelIconColor,
        ),
        title: Text(
          dob,
          style: AppTextStyles.profilePageLabelsStyle(),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.phone_android_outlined,
          size: 30.0,
          color: AppColor.profilePagelabelIconColor,
        ),
        title: Text(
          mobile,
          style: AppTextStyles.profilePageLabelsStyle(),
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.location_on_outlined,
          size: 30.0,
          color: AppColor.profilePagelabelIconColor,
        ),
        title: Text(
          address,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.profilePageLabelsStyle(),
        ),
      ),
    ],
  );
}
