import 'package:flutter/material.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:provider/provider.dart';

class EmotionbtnYellow extends StatefulWidget {
  @override
  _EmotionbtnYellowState createState() => _EmotionbtnYellowState();
}

class _EmotionbtnYellowState extends State<EmotionbtnYellow> {
  bool _isSelected = false;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;
  bool _isSelected6 = false;
  List<String> moodData = [
    "Curious",
    "Amazed",
    "Accompished",
    "Flabbergasted",
    "Entertained",
    "Pumped",
    "Hyper"
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
                  _isSelected = true;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                  _isSelected6 = false;
                });
                moodtask.applyMood(moodData[0]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Curious",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
                  _isSelected = false;
                  _isSelected1 = true;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                  _isSelected6 = false;
                });
                moodtask.applyMood(moodData[1]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected1 ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Amazed",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
                  _isSelected = false;
                  _isSelected1 = false;
                  _isSelected2 = true;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                  _isSelected6 = false;
                });
                moodtask.applyMood(moodData[2]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected2 ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Accomplished",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
                  _isSelected = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = true;
                  _isSelected4 = false;
                  _isSelected5 = false;
                  _isSelected6 = false;
                });
                moodtask.applyMood(moodData[3]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected3 ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Flabbergasted",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
                  _isSelected = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = true;
                  _isSelected5 = false;
                  _isSelected6 = false;
                });
                moodtask.applyMood(moodData[4]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected4 ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Entertained",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
                  _isSelected = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = true;
                  _isSelected6 = false;
                });
                moodtask.applyMood(moodData[5]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected5 ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Pumped",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
                  _isSelected = false;
                  _isSelected1 = false;
                  _isSelected2 = false;
                  _isSelected3 = false;
                  _isSelected4 = false;
                  _isSelected5 = false;
                  _isSelected6 = true;
                });
                moodtask.applyMood(moodData[6]);
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: _isSelected6 ? Color(0xfffffaec) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Hyper",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfff2c94c),
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
