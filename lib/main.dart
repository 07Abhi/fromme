import 'package:flutter/material.dart';
import 'package:fromme/chatservice/chatwindow.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:fromme/pages/drawer_pages/moodpost.dart';
import 'package:fromme/pages/drawer_pages/privacypage.dart';
import 'package:fromme/pages/drawer_pages/profilepage.dart';
import 'package:fromme/pages/drawer_pages/tandcpage.dart';
import 'package:fromme/pages/homebookmark.dart';
import 'package:fromme/pages/loginpages/forgetpasswordpage.dart';
import 'package:fromme/pages/loginpages/loginpage.dart';
import 'package:fromme/pages/loginpages/signuppage.dart';
import 'package:fromme/pages/messagepages/emptypostscreen.dart';
import 'package:fromme/pages/messagepages/nodatafound.dart';
import 'package:fromme/pages/messagepages/nofeeds.dart';
import 'package:fromme/pages/messagepages/nointernetpage.dart';
import 'package:fromme/pages/messagepages/somethingwentwrong.dart';
import 'package:fromme/pages/messagepages/splashscreen.dart';
import 'package:fromme/pages/navigation_pages/chatpage.dart';
import 'package:fromme/pages/navigation_pages/contactspage.dart';
import 'package:fromme/pages/navigation_pages/giftpage.dart';
import 'package:fromme/pages/navigation_pages/homepage.dart';
import 'package:fromme/pages/navigation_pages/moodpostmini.dart';
import 'package:fromme/pages/setting_pages/aboutus.dart';
import 'package:fromme/pages/setting_pages/changenumber.dart';
import 'package:fromme/pages/setting_pages/contactus.dart';
import 'package:fromme/pages/setting_pages/editprofile.dart';
import 'package:fromme/pages/setting_pages/faqpage.dart';
import 'package:fromme/pages/setting_pages/notification.dart';
import 'package:fromme/pages/setting_pages/settings.dart';
import 'package:fromme/pages/timelinepage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

VoidCallback onRefreshProfile;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MoodManager())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff2DC4D9),
          accentColor: Colors.cyan.shade800,
          fontFamily: "Roboto",
        ),
        home: LoginPage(),
        routes: {
          //loginpages
          LoginPage.id: (context) => LoginPage(),
          SignUpPage.id: (context) => SignUpPage(),
          ForgetPasswordPage.id: (context) => ForgetPasswordPage(),
          //InAppPages
          HomePage.id: (context) => HomePage(),
          EditProfilePage.id: (context) => EditProfilePage(),
          //messagepages
          EmptyPostScreen.id: (context) => EmptyPostScreen(),
          NoDataFound.id: (context) => NoDataFound(),
          NoFeeds.id: (context) => NoFeeds(),
          NoInternetPage.id: (context) => NoInternetPage(),
          SomethingwentW.id: (context) => SomethingwentW(),
          SplashPage.id: (context) => SplashPage(),
          //drawerpages
          TermsAndConditions.id: (context) => TermsAndConditions(),
          PrivacyPage.id: (context) => PrivacyPage(),
          SettingPage.id: (context) => SettingPage(),
          ProfilePage.id: (context) => ProfilePage(),
          MoodPost.id: (context) => MoodPost(),
          HomeBookMark.id: (context) => HomeBookMark(),
          MoodPostMini.id: (context) => MoodPostMini(),
          //setingsPage
          AboutUs.id: (context) => AboutUs(),
          FAQPage.id: (context) => FAQPage(),
          ContactUs.id: (context) => ContactUs(),
          NotificationPage.id: (context) => NotificationPage(),
          ChangeNumber.id: (context) => ChangeNumber(),
          //buttomNavigationPage
          TimeLinePage.id: (context) => TimeLinePage(),
          ContactPage.id: (context) => ContactPage(),
          GiftPage.id: (context) => GiftPage(),
          //chatpages
          ChatPage.id: (context) => ChatPage(),
          ChatWindow.id: (context) => ChatWindow(),
        },
      ),
    );
  }
}
