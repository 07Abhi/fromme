import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/pages/setting_pages/editprofile.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'aboutus.dart';
import 'changenumber.dart';
import 'contactus.dart';
import 'faqpage.dart';
import 'notification.dart';

class SettingPage extends StatelessWidget {
  static const String id = "/settings";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Edit Profile",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, EditProfilePage.id),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
          ListTile(
            title: Text(
              "Change/Add Mobile",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, ChangeNumber.id),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
          ListTile(
            title: Text(
              "Font Size",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
          ListTile(
            title: Text(
              "Notifications",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, NotificationPage.id),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
          ListTile(
            title: Text(
              "FAQ's",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, FAQPage.id),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
          ListTile(
            title: Text(
              "About Us",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, AboutUs.id),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
          ListTile(
            title: Text(
              "Contact Us",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, ContactUs.id),
          ),
          Divider(
            thickness: 2.0,
            color: AppColor.settingPageDividerColor,
          ),
        ],
      ),
    );
  }
}
