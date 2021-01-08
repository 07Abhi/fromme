import 'package:flutter/material.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:provider/provider.dart';

class Emotionbtngreen extends StatefulWidget {
  @override
  _EmotionbtngreenState createState() => _EmotionbtngreenState();
}

class _EmotionbtngreenState extends State<Emotionbtngreen> {
  bool _isSelected0 = false;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;
  List<String> moodData = [
    "Positive",
    "Happy",
    "Excited",
    "Proud",
    "Determined",
    "Inspired"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodManager>(
      builder: (context, moodtask, child) => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected0 = true;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                });
                moodtask.applyMood(moodData[0]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected0 ? Color(0xffdeffec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Positive",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff219653),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected0 = false;
                  _isSelected1 = true;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                });
                moodtask.applyMood(moodData[1]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected1 ? Color(0xffdeffec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Happy",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff219653),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected0 = false;
                  _isSelected1 = false;
                  _isSelected2 = true;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                });
                moodtask.applyMood(moodData[2]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected2 ? Color(0xffdeffec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Excited",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff219653),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected0 = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = true;
                  _isSelected4 = false;
                  _isSelected5 = false;
                });
                moodtask.applyMood(moodData[3]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected3 ? Color(0xffdeffec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Proud",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff219653),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected0 = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = true;
                  _isSelected5 = false;
                });
                moodtask.applyMood(moodData[4]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected4 ? Color(0xffdeffec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Determined",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff219653),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected0 = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = true;
                });
                moodtask.applyMood(moodData[5]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected5 ? Color(0xffdeffec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Inspired",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff219653),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
