import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/pages/setting_pages/editprofile.dart';
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
          AppConstantsWidgets.basicDivider(),
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
          AppConstantsWidgets.basicDivider(),
          ListTile(
            title: Text(
              "Font Size",
              style: AppTextStyles.settingPageStyle(),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          AppConstantsWidgets.basicDivider(),
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
          AppConstantsWidgets.basicDivider(),
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
          AppConstantsWidgets.basicDivider(),
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
          AppConstantsWidgets.basicDivider(),
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
          AppConstantsWidgets.basicDivider(),
        ],
      ),
    );
  }
}
