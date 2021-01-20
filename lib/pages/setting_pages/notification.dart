import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class NotificationPage extends StatefulWidget {
  static const String id = "/notifictaion";

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _pushNoti = true;
  bool _messageNoti = false;
  bool _requestNoti = false;
  bool _callNoti = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Push Notifications",
              style: AppTextStyles.settingNotificationLableStyle(),
            ),
            trailing: Switch(
              value: _pushNoti,
              onChanged: (val) {
                setState(
                  () {
                    _pushNoti = val;
                  },
                );
              },
              activeTrackColor: AppColor.notificationActiveTrackColor,
              inactiveThumbColor: AppColor.notificationInactiveThumbColor,
              inactiveTrackColor: AppColor.notificationInactiveTrackColor,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColor.notificationDividerColor,
          ),
          ListTile(
            title: Text(
              "Message Notifications",
              style: AppTextStyles.settingNotificationLableStyle(),
            ),
            trailing: Switch(
              value: _messageNoti,
              onChanged: (val) {
                setState(
                  () {
                    _messageNoti = val;
                  },
                );
              },
              activeTrackColor: AppColor.notificationActiveTrackColor,
              inactiveThumbColor: AppColor.notificationInactiveThumbColor,
              inactiveTrackColor: AppColor.notificationInactiveTrackColor,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColor.notificationDividerColor,
          ),
          ListTile(
            title: Text(
              "Request Notifications",
              style: AppTextStyles.settingNotificationLableStyle(),
            ),
            trailing: Switch(
              value: _requestNoti,
              onChanged: (val) {
                setState(
                  () {
                    _requestNoti = val;
                  },
                );
              },
              activeTrackColor: AppColor.notificationActiveTrackColor,
              inactiveThumbColor: AppColor.notificationInactiveThumbColor,
              inactiveTrackColor: AppColor.notificationInactiveTrackColor,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColor.notificationDividerColor,
          ),
          ListTile(
            title: Text(
              "Call Notifications",
              style: AppTextStyles.settingNotificationLableStyle(),
            ),
            trailing: Switch(
              value: _callNoti,
              onChanged: (val) {
                setState(
                  () {
                    _callNoti = val;
                  },
                );
              },
              activeTrackColor: AppColor.notificationActiveTrackColor,
              inactiveThumbColor: AppColor.notificationInactiveThumbColor,
              inactiveTrackColor: AppColor.notificationInactiveTrackColor,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColor.notificationDividerColor,
          )
        ],
      ),
    );
  }
}
