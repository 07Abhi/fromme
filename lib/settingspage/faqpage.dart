import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FAQPage extends StatelessWidget {
  static const String id = "/faqPage";

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandTiles(
              question: "Question 1",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
            ExpandTiles(
              question: "Question 2",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
            ExpandTiles(
              question: "Question 3",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
            ExpandTiles(
              question: "Question 4",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandTiles extends StatefulWidget {
  String question;
  String solution;
  ExpandTiles({this.question, this.solution});
  @override
  _ExpandTilesState createState() => _ExpandTilesState();
}

class _ExpandTilesState extends State<ExpandTiles> {
  bool _isExpanded = false;

  void _expandFunc() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70.0,
          width: MediaQuery.of(context).size.width,
          color: Color(0xfff1f1f1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                _isExpanded
                    ? IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          size: 25.0,
                        ),
                        onPressed: () => _expandFunc(),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          size: 25.0,
                        ),
                        onPressed: () => _expandFunc(),
                      )
              ],
            ),
          ),
        ),
        Visibility(
          visible: _isExpanded,
          child: Container(
            height: 120.0,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfff1f1f1),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.solution,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
//'We don not keep the copy of your password. However, you can reset your password from the login screen of the app. We do not keep the copy of your password. However, you can reset your password from the login screen.'