import 'package:flutter/material.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';
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
                  color: _isSelected
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Curious",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
                  color: _isSelected1
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Amazed",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
                  color: _isSelected2
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Accomplished",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
                  color: _isSelected3
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Flabbergasted",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
                  color: _isSelected4
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Entertained",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
                  color: _isSelected5
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Pumped",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
                  color: _isSelected6
                      ? AppColor.emotionTilesyellowSelectedColor
                      : AppColor.emotionTilesUnselectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    "Hyper",
                    style: AppTextStyles.emotionTilesYelowStyle(),
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
