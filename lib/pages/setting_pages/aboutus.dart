import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class AboutUs extends StatelessWidget {
  static const String id = "/aboutus";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About us',
                style: AppTextStyles.settingPageHeadingStyle(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "An About Us page helps your company make a good first impression, and is critical for building customer trust and loyalty. An About Us page should make sure to cover basic information about the store and its founders, explain the company's purpose and how it differs from the competition, and encourage discussion and interaction. Here are some free templates,samples, and example About Us pages to help your ecommerce store stand out from the crowd.\n An About Us page helps your company make a good first impression, and is critical for building customer trust and loyalty. An About Us page should make sure to cover basic information about the store and its founders, explain the companys purpose and how it differs from the competition, and encourage discussion and interaction. Here are some free templates, samples, and example About Us pages to help your ecommerce store stand out from the crowd.",
                  style: AppTextStyles.settingPageInfoStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
