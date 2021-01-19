import 'package:flutter/material.dart';
import 'package:fromme/moodpostmanager/moodmanager.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:provider/provider.dart';

class Emotionbtnblue extends StatefulWidget {
  @override
  _EmotionbtnblueState createState() => _EmotionbtnblueState();
}

class _EmotionbtnblueState extends State<Emotionbtnblue> {
  bool _isSelected0 = false;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  List<String> moods = ["Sad", "Worried", "Negative", "Lonely", "Depressed"];

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodManager>(
      builder: (context, moodTask, child) {
        return ListView(
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
                  });
                  moodTask.applyMood(moods[0]);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    color: _isSelected0
                        ? AppColor.emotionTilesBlueSelectedColor
                        : AppColor.emotionTilesUnselectedColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      moods[0],
                      style: AppTextStyles.emotionTilesBlueStyle(),
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
                  });
                  moodTask.applyMood(moods[1]);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    color: _isSelected1
                        ? AppColor.emotionTilesBlueSelectedColor
                        : AppColor.emotionTilesUnselectedColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      moods[1],
                      style: AppTextStyles.emotionTilesBlueStyle(),
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
                  });
                  moodTask.applyMood(moods[2]);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    color: _isSelected2
                        ? AppColor.emotionTilesBlueSelectedColor
                        : AppColor.emotionTilesUnselectedColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      moods[2],
                      style: AppTextStyles.emotionTilesBlueStyle(),
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
                  });
                  moodTask.applyMood(moods[3]);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    color: _isSelected3
                        ? AppColor.emotionTilesBlueSelectedColor
                        : AppColor.emotionTilesUnselectedColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      moods[3],
                      style: AppTextStyles.emotionTilesBlueStyle(),
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
                  });
                  moodTask.applyMood(moods[4]);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    color: _isSelected4
                        ? AppColor.emotionTilesBlueSelectedColor
                        : AppColor.emotionTilesUnselectedColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      moods[4],
                      style: AppTextStyles.emotionTilesBlueStyle(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
