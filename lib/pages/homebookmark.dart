import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:fromme/widgets/emotion_tiles_widgets/emotionbtnblue.dart';
import 'package:fromme/widgets/emotion_tiles_widgets/emotionbtngreen.dart';
import 'package:fromme/widgets/emotion_tiles_widgets/emotionbtnred.dart';
import 'package:fromme/widgets/emotion_tiles_widgets/emotionbuttonyellow.dart';

class HomeBookMark extends StatefulWidget {
  static String id = "/homebookmark";
  @override
  _HomeBookMarkState createState() => _HomeBookMarkState();
}

class _HomeBookMarkState extends State<HomeBookMark> {
  List<Widget> _emotions = [
    Emotionbtngreen(),
    EmotionbtnYellow(),
    EmotionBtnRed(),
    Emotionbtnblue(),
  ];
  int _currentIndex = 0;
  PageController _controller = new PageController();
  void _onChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "How are you feeling?",
              style: AppTextStyles.homeBookmarkTitleStyle(),
            ),
          ),
          Container(
            height: 590.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemCount: _emotions.length,
                    onPageChanged: _onChanged,
                    itemBuilder: (context, index) {
                      return _emotions[index];
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          _emotions.length,
                          (int index) => Container(
                            height: 20.0,
                            width: (index == _currentIndex) ? 15 : 10,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (index == _currentIndex)
                                  ? AppColor.homeBookMarkcolor2
                                  : AppColor.homeBookMarkcolor1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
