import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fromme/pages/drawer_pages/moodpost.dart';
import 'package:fromme/pages/drawer_pages/privacypage.dart';
import 'package:fromme/pages/drawer_pages/profilepage.dart';
import 'package:fromme/pages/drawer_pages/tandcpage.dart';
import 'package:fromme/pages/loginpages/loginpage.dart';
import 'package:fromme/pages/navigation_pages/chatpage.dart';
import 'package:fromme/pages/navigation_pages/contactspage.dart';
import 'package:fromme/pages/navigation_pages/giftpage.dart';
import 'package:fromme/pages/navigation_pages/moodpostmini.dart';
import 'package:fromme/pages/setting_pages/settings.dart';
import 'package:fromme/pages/timelinepage.dart';
import 'package:fromme/widgets/circles.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    GiftPage()
  ];

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    if (widget.faceBookData != null) {
      await widget.faceBookData.logOut();
      widget.firebaseAuth.signOut();
      makeUserOffline();
      Navigator.pushReplacementNamed(context, LoginPage.id);
      Toast.show(
        "Logout Succesfully!!",
        context,
        duration: 2,
        gravity: 0,
        textColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      );
    } else if (widget.googleData != null) {
      await widget.googleData.signOut();
      widget.firebaseAuth.signOut();
      makeUserOffline();
      Navigator.pushReplacementNamed(context, LoginPage.id);
      Toast.show(
        "Logout Succesfully!!",
        context,
        duration: 2,
        gravity: 0,
        textColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      );
    } else {
      if (widget.firebaseAuth != null) {
        widget.firebaseAuth.signOut();
      } else {
        _firebaseAuth.signOut();
      }
      makeUserOffline();
      Navigator.pushReplacementNamed(context, LoginPage.id);
      Toast.show(
        "Logout Succesfully!!",
        context,
        duration: 2,
        gravity: 0,
        textColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      );
    }
  }

  getUserName() async {
    setState(() {
      isLoading = true;
    });
    print(_firebaseAuth.currentUser.uid);
    print(_firebaseAuth.currentUser.email);

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

  makeUserOnline() async {
    _firestore
        .collection('userdata')
        .doc(_firebaseAuth.currentUser.uid)
        .update({
      "isOnline": true,
    });
  }

  makeUserOffline() async {
    _firestore
        .collection('userdata')
        .doc(_firebaseAuth.currentUser.uid)
        .update({
      "isOnline": false,
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
    makeUserOnline();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));

    return isLoading
        ? Scaffold(
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
              ),
            ),
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 1.0,
                            top: 12.0,
                            child: Circles(
                              height: 18.0,
                              width: 18.0,
                            ),
                          ),
                          Positioned(
                            bottom: 4.0,
                            left: 5.0,
                            child: Circles(
                              height: 16.0,
                              width: 16.0,
                            ),
                          ),
                          Positioned(
                            left: 22.0,
                            child: Circles(
                              height: 22.0,
                              width: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context) => <PopupMenuItem<action>>[
                      const PopupMenuItem<action>(
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        value: action.logout,
                      ),
                    ],
                    onSelected: (val) async {
                      if (val == action.logout) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLogged', false);
                        _signOut();
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
                                        "https://image.flaticon.com/icons/png/512/64/64572.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Text(
                                    username ?? "Username",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.w700,
                                    ),
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
                            color: Color(0xff2AC2D7),
                          ),
                          title: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff272727),
                            ),
                          ),
                          onTap: () =>
                              Navigator.pushNamed(context, MoodPost.id),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.bubble_chart_outlined,
                            size: 35.0,
                            color: Color(0xff2AC2D7),
                          ),
                          title: Text(
                            "Bubbles",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff272727),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.payments_outlined,
                            size: 35.0,
                            color: Color(0xff2AC2D7),
                          ),
                          title: Text(
                            "Payments",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff272727),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            size: 35.0,
                            color: Color(0xff2AC2D7),
                          ),
                          title: Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff272727),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, SettingPage.id);
                            //To close the drawer of the scaffold
                            _scaffKey.currentState.openEndDrawer();
                          },
                        ),
                        ListTile(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isLogged', false);
                            _signOut();
                          },
                          leading: Icon(
                            Icons.exit_to_app,
                            size: 35.0,
                            color: Color(0xff2AC2D7),
                          ),
                          title: Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff272727),
                            ),
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
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color(0xff272727),
                              ),
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
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color(0xff272727),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Version 1.0.0",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xff272727),
                            ),
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
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Color(0xff999999),
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
                    color: Theme.of(context).primaryColor,
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
