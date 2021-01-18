import 'package:flutter/material.dart';

class EmptyPostScreen extends StatefulWidget {
  static const id = "/emptyScreen";
  @override
  _EmptyPostScreenState createState() => _EmptyPostScreenState();
}

class _EmptyPostScreenState extends State<EmptyPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 400.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/emptyimage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 250.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.contact_phone_outlined,
                        size: 40.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Sync your phonebook",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.bubble_chart_outlined,
                        size: 40.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Create a Bubble",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.widgets_outlined,
                        size: 40.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Create Personalized posts for different bubbles.",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
