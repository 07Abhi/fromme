import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class FAQPage extends StatelessWidget {
  static const String id = "/faqPage";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppConstantsWidgets.fixedAppBarWithGradient(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandedTiles(
              question: "Question 1",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
            ExpandedTiles(
              question: "Question 2",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
            ExpandedTiles(
              question: "Question 3",
              solution: "Particular Answer",
            ),
            SizedBox(
              height: 15.0,
            ),
            ExpandedTiles(
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

class ExpandedTiles extends StatefulWidget {
  final String question;
  final String solution;
  ExpandedTiles({this.question, this.solution});
  @override
  _ExpandTilesState createState() => _ExpandTilesState();
}

class _ExpandTilesState extends State<ExpandedTiles> {
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
          color: AppColor.faqTilesColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: AppTextStyles.faqQuestionTextStyle(),
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
            color: AppColor.faqTilesColor,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.solution,
                  style: AppTextStyles.faqAnswerTextStyle(),
                )),
          ),
        )
      ],
    );
  }
}
