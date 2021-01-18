import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "How are you feeling?",
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff007888)),
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
                                  ? Theme.of(context).primaryColor
                                  : Colors.cyan.shade100,
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
