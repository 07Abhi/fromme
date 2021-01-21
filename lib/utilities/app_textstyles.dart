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

  //login registration and forget password textfirld decoration.
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

  //change mobile number textfield decoration
  static settingChangeMobileDecoration(BuildContext context,
      TextEditingController mobileController, String hint) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.grey.shade500,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).primaryColor,
        ),
      ),
      prefixIcon: Icon(Icons.phone),
      suffixIcon: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          mobileController.clear();
        },
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

  static TextStyle loginOptionTextStyle() {
    return TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColor.loginChoiceTextColor);
  }

  static TextStyle forgetPassInfoStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColor.forgetpassInformationColor,
    );
  }

  static TextStyle appBarTitleStyle2() {
    return TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.w600,
      color: AppColor.appBarHeadingColor,
      fontFamily: "LovedByTheKing",
      shadows: [
        Shadow(
          offset: Offset(0, 3.0),
          blurRadius: 2.0,
          color: AppColor.appBarShadowColor,
        )
      ],
    );
  }

  static TextStyle homeBookmarkTitleStyle() {
    return TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      color: AppColor.homeBookmarkTitleColor,
    );
  }

  static TextStyle timelinePageNameStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: AppColor.timelinePageNameColor,
    );
  }

  static TextStyle timelinePageTimeStampStyle() {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColor.timelinePageTimeColor,
    );
  }

  static TextStyle timelinePageEmotionStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
      color: AppColor.timelinePageEmotionColor,
    );
  }

  static TextStyle timelinePagePostMessageStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle settingPageHeadingStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle settingPageInfoStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle faqQuestionTextStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColor.faqQuestionColor,
    );
  }

  static TextStyle faqAnswerTextStyle() {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: AppColor.faqQuestionColor,
    );
  }

  static TextStyle settingNotificationLableStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle uploadImageTextStyle() {
    return TextStyle(
      fontSize: 18.0,
      color: AppColor.uploadImageTextColor,
    );
  }

  static TextStyle editProfileHeadingStyle() {
    return TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      color: AppColor.primaryColor,
    );
  }

  static TextStyle editGenderLableStyle() {
    return TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: AppColor.primaryColor);
  }

  static TextStyle editProfileRadioStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColor.editProfileRadioLableColor,
    );
  }

  static TextStyle settingPageStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle homePageLogOutBtnStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColor.circleLogoubtnText,
    );
  }

  static TextStyle homePageDrawerUsernameStyle() {
    return TextStyle(
      fontSize: 23.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle drawertilesStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColor.drawerLableTextColor,
    );
  }

  static TextStyle drawerBottomLabelTextStyle(double fsize) {
    return TextStyle(
      fontSize: fsize,
      color: AppColor.drawerLableTextColor,
    );
  }

  static TextStyle moodPostEmotionStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w900,
      color: AppColor.userPostEmotionColor,
    );
  }

  static TextStyle moodpostTextFieldStyle() {
    return TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    );
  }

  static moodPostDecoration(String hinttxt) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      hintText: hinttxt,
      hintStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
        color: AppColor.moodPostinputColor,
      ),
    );
  }

  static InputDecoration moodPostSearchFeildDecoration({String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
            color: AppColor.moodPostSearchBarBorderColor, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
            color: AppColor.moodPostSearchBarBorderColor, width: 2.0),
      ),
    );
  }

  static TextStyle moodpostParticularUserTileStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle moodPostParticularUserButtonStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle moodPostShareBtnStyle() {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle moodpostShareWithStyle() {
    return TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle privacyPolicyHeadingStyle() {
    return TextStyle(
      color: AppColor.privacyPolicyHeadingColor,
      fontSize: 25.0,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle privacyPolicyInfoStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle profilePageNameStyle() {
    return TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w800,
      color: AppColor.profilePageNameColor,
    );
  }

  static TextStyle profilePageHeadingStyle() {
    return TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      color: AppColor.primaryColor,
    );
  }

  static TextStyle profilePageLabelsStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: AppColor.profilePageEmailColor,
    );
  }

  static TextStyle contactPageNameStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColor.contactPageNameColor,
    );
  }

  static TextStyle contactPageDetailsStyle() {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: AppColor.contactPageNameColor,
    );
  }

  static InputDecoration chatPageTextFieldDecoration({String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColor.chatPageSearchHintColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 1.5,
          color: AppColor.chatPageTextFieldBorder,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 1.5,
          color: AppColor.chatPageTextFieldBorder,
        ),
      ),
    );
  }

  static TextStyle searchChatResultNotFoundStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryColor,
    );
  }

  static TextStyle chatTileMsgBtnTextStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  static TextStyle chatTileNameStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle chatUserActiveStatusStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle chatUserTilesNameStyle() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle chatWindowNameStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
    );
  }

  static InputDecoration chatMessageContainerTextFieldDecoration() {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.chatMessageContainerBorderSidesColor,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffbbdefb),
        ),
      ),
      prefixIcon: Icon(
        Icons.chat,
        color: AppColor.chatMessageConatinerBorderColor,
        size: 30.0,
      ),
      hintText: 'Type Message....',
      hintStyle: TextStyle(
        color: AppColor.chatMessageConatinerBorderColor,
      ),
    );
  }

  static TextStyle chatMessageTextStyle() {
    return TextStyle(
      color: AppColor.chatMessageColor,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }
}
