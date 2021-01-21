import 'package:flutter/material.dart';
import 'package:fromme/models/contactsmodel.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class ExpandTiles extends StatefulWidget {
  final ContactModel userDetails;
  ExpandTiles({this.userDetails});

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            color: AppColor.contactTilesColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(widget.userDetails.photoUrl),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      widget.userDetails.name,
                      style: AppTextStyles.contactPageNameStyle(),
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
              height: 130.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email:- ",
                          style: AppTextStyles.contactPageDetailsStyle(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.userDetails.email,
                            style: AppTextStyles.contactPageDetailsStyle(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile:- ",
                          style: AppTextStyles.contactPageDetailsStyle(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.userDetails.mobile,
                            style: AppTextStyles.contactPageDetailsStyle(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address:- ",
                          style: AppTextStyles.contactPageDetailsStyle(),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.userDetails.address,
                            style: AppTextStyles.contactPageDetailsStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
