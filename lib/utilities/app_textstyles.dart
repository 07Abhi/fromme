import 'package:flutter/material.dart';
import 'package:fromme/utilities/app_colors.dart';

class AppTextStyles {
  //TextFormFieldStyles
  static TextStyle logonformTextStyle() {
    return TextStyle(
      fontSize: 18.0,
      color: AppColor.textFieldInputColor,
      fontWeight: FontWeight.w600,
    );
  }

  static InputDecoration textFieldDecoration(String name) {
    return InputDecoration(
      focusColor: Colors.grey.shade400,
      labelText: "$name*",
      labelStyle: TextStyle(
        color: AppColor.textFieldLabelColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  //AppBar & Scaffold Stuff Styles
  static TextStyle appBarTitleStyle() {
    return TextStyle(
      fontSize: 50.0,
      fontWeight: FontWeight.w600,
      color: AppColor.appBarHeadingColor,
      fontFamily: "LovedByTheKing",
    );
  }

  static TextStyle appPagesHeading() {
    return TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w800,
      color: AppColor.pageHeadingColor,
    );
  }

  static TextStyle appTandCTextStyles() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: AppColor.appTandCcolor,
    );
  }

  static TextStyle bottomInfoTextStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: AppColor.bottomTextColor,
    );
  }

  static TextStyle btnTextStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: AppColor.bottonTextColor,
    );
  }

  static TextStyle bottomSecondTextStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColor.bottomsecondColor,
    );
  }

  static TextStyle bottomSecondHighlightTextStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColor.bottomsecondHighlightColor,
    );
  }

  static TextStyle emotionTilesBlueStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: AppColor.emotionTilesBlueColor,
    );
  }

  static TextStyle emotionTilesGreenStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: AppColor.emotionTilesGreenColor,
    );
  }

  static TextStyle emotionTilesRedStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: AppColor.emotionTilesRedColor,
    );
  }

  static TextStyle emotionTilesYelowStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: AppColor.emotionTilesYellowColor,
    );
  }

  static TextStyle addMemberWidgetTextStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle postOptionWidgetsTextStyle(Color colors) {
    return TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
      color: colors,
    );
  }

  static TextStyle userPostNameStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: AppColor.userPostNameColor,
    );
  }

  static TextStyle userPostTimeStyle() {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColor.userPostTimeColor,
    );
  }

  static TextStyle userPostEmotionStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: AppColor.userPostEmotionColor,
    );
  }

  static TextStyle usePostIndexStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle userPostBottomBarStyle() {
    return TextStyle(
      color: AppColor.userPostBottomTextColor,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
    );
  }
}
