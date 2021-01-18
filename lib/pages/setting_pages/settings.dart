import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/pages/setting_pages/editprofile.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0.0,
          shadowColor: Colors.white,
          title: Text(
            "FromMe",
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w600,
              color: Colors.cyan.shade400,
              fontFamily: "LovedByTheKing",
              shadows: [
                Shadow(
                  offset: Offset(0, 3.0),
                  blurRadius: 2.0,
                  color: Colors.grey.shade400,
                )
              ],
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff41b1c0),
                  Colors.white,
                ],
                stops: [
                  0.1,
                  0.8,
                ],
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              size: 40.0,
              color: Color(0xff2DC4D9),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, EditProfilePage.id),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: Text(
              "Change/Add Mobile",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, ChangeNumber.id),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: Text(
              "Font Size",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, NotificationPage.id),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: Text(
              "FAQ's",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, FAQPage.id),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: Text(
              "About Us",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, AboutUs.id),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
            ),
            onTap: () => Navigator.pushNamed(context, ContactUs.id),
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
