import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoDataFound extends StatelessWidget {
  static const id = "/nodataFound";

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200.0,
                width: 200.0,
                child: Placeholder(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "No Data Found",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ButtonTheme(
                height: 60.0,
                minWidth: MediaQuery.of(context).size.width * 0.3,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
