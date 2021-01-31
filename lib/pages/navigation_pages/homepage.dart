import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fromme/pages/drawer_pages/moodpost.dart';
import 'package:fromme/pages/drawer_pages/privacypage.dart';
import 'package:fromme/pages/drawer_pages/profilepage.dart';
import 'package:fromme/pages/drawer_pages/tandcpage.dart';
import 'package:fromme/pages/navigation_pages/chatpage.dart';
import 'package:fromme/pages/navigation_pages/contactspage.dart';
import 'package:fromme/pages/navigation_pages/giftpage.dart';
import 'package:fromme/pages/navigation_pages/moodpostmini.dart';
import 'package:fromme/pages/setting_pages/settings.dart';
import 'package:fromme/pages/timelinepage.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_strings.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_login_provider.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:fromme/widgets/circles_btn.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fromme/main.dart';

enum action { logout }

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const String id = "/homePage";
  FacebookLogin faceBookData;
  GoogleSignIn googleData;
  FirebaseAuth firebaseAuth;
  HomePage({
    this.faceBookData,
    this.firebaseAuth,
    this.googleData,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot userData;
  bool isLoading = false;
  int _selectedIndex = 0;
  String username;
  String photoUrl;
  List pages = [
    TimeLinePage(),
    ContactPage(),
    MoodPostMini(),
    ChatPage(),
    GiftPage(),
    // NotifcationPageTest()
  ];
  List pages1 = [
    Center(child: Text("hello world")),
    Center(child: Text("hello world")),
    MoodPostMini(),
    Center(child: Text("hello world")),
    Center(child: Text("hello world")),
  ];

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getUserName() async {
    setState(() {
      isLoading = true;
    });

    userData = await _firestore
        .collection('userdata')
        .doc(_firebaseAuth.currentUser.uid)
        .get();

    setState(() {
      username = userData['name'];
      photoUrl = userData['photoUrl'];
      isLoading = false;
    });
  }

  VoidCallback _refreshFunction() {
    getUserName();
  }

  @override
  void initState() {
    super.initState();
    onRefreshProfile = _refreshFunction;
    getUserName();
    LoginProvider.makeUserOnline(_firebaseAuth.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));

    return isLoading
        ? Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white54,
                strokeWidth: 5.0,
              ),
            ),
          )
        : Scaffold(
            key: _scaffKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey.shade100,
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
                    color: AppColor.appBarHeadingColor,
                    fontFamily: "LovedByTheKing",
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3.0),
                        blurRadius: 2.0,
                        color: AppColor.appBarShadowColor,
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
                  onPressed: () {
                    _scaffKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.grey.shade400,
                    size: 45.0,
                  ),
                ),
                actions: [
                  PopupMenuButton<action>(
                    child: Container(
                      height: 70.0,
                      width: 60.0,
                      color: Colors.white.withOpacity(0.0),
                      child: circlesWidget(),
                    ),
                    itemBuilder: (context) => <PopupMenuItem<action>>[
                      const PopupMenuItem<action>(
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: AppColor.circleLogoubtnText,
                          ),
                        ),
                        value: action.logout,
                      ),
                    ],
                    onSelected: (val) async {
                      if (val == action.logout) {
                        AppConstantsWidgets.setLoginPrefference(false);
                        LoginProvider.signOut(context, widget.faceBookData,
                            widget.googleData, widget.firebaseAuth);
                      }
                    },
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 220.0,
                          child: DrawerHeader(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProfilePage.id,
                                    );
                                    _scaffKey.currentState.openEndDrawer();
                                  },
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage(photoUrl ??
                                        AppConstantString.drawerImageUrl),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Text(
                                    username ?? "Username",
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles
                                        .homePageDrawerUsernameStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.pages,
                            size: 35.0,
                            color: AppColor.drawerIconColor,
                          ),
                          title: Text(
                            "Post",
                            style: AppTextStyles.drawertilesStyle(),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, MoodPost.id);
                            _scaffKey.currentState.openEndDrawer();
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.bubble_chart_outlined,
                            size: 35.0,
                            color: AppColor.drawerIconColor,
                          ),
                          title: Text(
                            "Bubbles",
                            style: AppTextStyles.drawertilesStyle(),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.payments_outlined,
                            size: 35.0,
                            color: AppColor.drawerIconColor,
                          ),
                          title: Text(
                            "Payments",
                            style: AppTextStyles.drawertilesStyle(),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            size: 35.0,
                            color: AppColor.drawerIconColor,
                          ),
                          title: Text(
                            "Settings",
                            style: AppTextStyles.drawertilesStyle(),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, SettingPage.id);
                            //To close the drawer of the scaffold
                            _scaffKey.currentState.openEndDrawer();
                          },
                        ),
                        ListTile(
                          onTap: () async {
                            AppConstantsWidgets.setLoginPrefference(false);
                            LoginProvider.signOut(context, widget.faceBookData,
                                widget.googleData, widget.firebaseAuth);
                          },
                          leading: Icon(
                            Icons.exit_to_app,
                            size: 35.0,
                            color: AppColor.drawerIconColor,
                          ),
                          title: Text(
                            "Log Out",
                            style: AppTextStyles.drawertilesStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, TermsAndConditions.id);
                            _scaffKey.currentState.openEndDrawer();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Terms and Conditions",
                              style: AppTextStyles.drawerBottomLabelTextStyle(
                                  17.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PrivacyPage.id);
                            _scaffKey.currentState.openEndDrawer();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Privacy Policy",
                              style: AppTextStyles.drawerBottomLabelTextStyle(
                                  17.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Version 1.0.0",
                            style:
                                AppTextStyles.drawerBottomLabelTextStyle(15.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: _changeIndex,
              iconSize: 50.0,
              selectedItemColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.homepageBottomNavUnslectedColor,
              currentIndex: _selectedIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.phone,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    size: 60.0,
                    color: AppColor.primaryColor,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.card_giftcard,
                  ),
                  label: "",
                ),
              ],
            ),
            body: pages[_selectedIndex],
          );
  }
}
