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
}
