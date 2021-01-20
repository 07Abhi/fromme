import 'package:flutter/material.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class ContactUs extends StatefulWidget {
  static const String id = "/contactUs";

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
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
                'Connect with Us',
                style: AppTextStyles.settingPageHeadingStyle(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Contact Information will be posted soon!!!!!",
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
