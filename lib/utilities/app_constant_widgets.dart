import 'package:flutter/material.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toast/toast.dart';

class AppConstantsWidgets {
  //Scaffold Fixed AppBar
  static fixedAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: AppColor.scaffoldColor,
        elevation: 0.0,
        shadowColor: AppColor.scaffoldColor,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            size: 40.0,
            color: AppColor.appBarBackButtonColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "FromMe",
          style: AppTextStyles.appBarTitleStyle(),
        ),
        centerTitle: true,
      ),
    );
  }

//App bar second types along with gradient
  static fixedAppBarWithGradient(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70.0),
      child: AppBar(
        elevation: 0.0,
        shadowColor: Colors.white,
        title: Text(
          "FromMe",
          style: AppTextStyles.appBarTitleStyle2(),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.appBarShadowColor2,
                AppColor.appBarShadowColor1,
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
            color: AppColor.appBarBackButtonColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

//App's general toast
  static appToastDisplay(BuildContext context, {String info}) {
    return Toast.show(info, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white);
  }

//App's general scaffold snackbar
  static appGeneralSanckbar({String message}) {
    return SnackBar(
      content: Text(message),
      backgroundColor: AppColor.snackbarBackgroundColor,
      duration: Duration(seconds: 2),
    );
  }

  static setLoginPrefference(bool isLogin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogged', isLogin);
  }

  static basicDivider() {
    return Divider(
      thickness: 2.0,
      color: AppColor.settingPageDividerColor,
    );
  }
}
