import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationPage extends StatefulWidget {
  static const String id = "/notifictaion";
  bool _pushNoti = true;
  bool _messageNoti = false;
  bool _requestNoti = false;
  bool _callNoti = false;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Push Notifications",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch(
              value: widget._pushNoti,
              onChanged: (val) {
                setState(
                  () {
                    widget._pushNoti = val;
                  },
                );
              },
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade400,
          ),
          ListTile(
            title: Text(
              "Message Notifications",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch(
              value: widget._messageNoti,
              onChanged: (val) {
                setState(
                  () {
                    widget._messageNoti = val;
                  },
                );
              },
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade400,
          ),
          ListTile(
            title: Text(
              "Request Notifications",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch(
              value: widget._requestNoti,
              onChanged: (val) {
                setState(
                  () {
                    widget._requestNoti = val;
                  },
                );
              },
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade400,
          ),
          ListTile(
            title: Text(
              "Call Notifications",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch(
              value: widget._callNoti,
              onChanged: (val) {
                setState(
                  () {
                    widget._callNoti = val;
                  },
                );
              },
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
