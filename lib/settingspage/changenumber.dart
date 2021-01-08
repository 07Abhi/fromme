import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class ChangeNumber extends StatefulWidget {
  static const String id = "/changeNumber";

  @override
  _ChangeNumberState createState() => _ChangeNumberState();
}

class _ChangeNumberState extends State<ChangeNumber> {
  TextEditingController _mobileController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Registered Number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  decoration: InputDecoration(
                    hintText: "Mobile Number!!",
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
                        _mobileController.clear();
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ButtonTheme(
                    height: 50.0,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    child: FlatButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Toast.show(
                          "Change Request is send!!!",
                          context,
                          duration: 2,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
