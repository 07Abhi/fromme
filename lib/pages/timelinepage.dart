import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_strings.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:fromme/models/statusmodel.dart';
import 'package:fromme/widgets/userstatusbar.dart';

import 'navigation_pages/chatpage.dart';

class TimeLinePage extends StatefulWidget {
  static const String id = "/timelinepage";

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<StatusModel> _statusInfo = [];
  List<DocumentSnapshot> _moodposts = [];
  QuerySnapshot database;
  bool isLoading = true;
  int _perPage = 5;
  DocumentSnapshot _lastDocument;
  ScrollController _controller = new ScrollController();
  bool _gettingMoreData = false;
  bool _moreDataAvailable = true;
  Future<QuerySnapshot> getUserStoryTiles() async {
    database = await _firestore.collection('userdata').get();
    return database;
  }

//pagination section
  _getPostData() async {
    Query q = _firestore
        .collection('usermoodpost')
        .doc('allmoodpost')
        .collection('moodposts')
        .orderBy('name')
        .limit(_perPage);

    setState(() {
      isLoading = true;
    });
    QuerySnapshot queryData = await q.get();
    _moodposts = queryData.docs;
    _lastDocument = queryData.docs[queryData.docs.length - 1];

    setState(() {
      isLoading = false;
    });
  }

  _getMoreData() async {
    print("get more is called");
    if (_moreDataAvailable == false) {
      print("no data available");

      return;
    }
    if (_gettingMoreData == true) {
      return;
    }
    _gettingMoreData = true;
    Query q = _firestore
        .collection('usermoodpost')
        .doc('allmoodpost')
        .collection('moodposts')
        .orderBy('name')
        .startAfter([_lastDocument.data()['name']]).limit(_perPage);
    QuerySnapshot queryData = await q.get();
    if (queryData.docs.length < _perPage) {
      _moreDataAvailable = false;
    }
    _lastDocument = queryData.docs[queryData.docs.length - 1];
    _moodposts.addAll(queryData.docs);

    setState(() {});
    _gettingMoreData = false;
  }

  @override
  void initState() {
    _getPostData();
    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: getUserStoryTiles(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.circularProgressIndiColor,
                strokeWidth: 5.0,
              ),
            );
          }
          _statusInfo = [];
          snapshot.data.docs.forEach(
            (data) {
              if (_auth.currentUser.email != data['email']) {
                _statusInfo.add(
                  StatusModel(
                    isOnline: data['isOnline'],
                    photoUrl:
                        data['photoUrl'] ?? AppConstantString.timelinePhotoUrl,
                  ),
                );
              }
            },
          );
          return Column(
            children: [
              userStatusBar(context, _statusInfo),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: isLoading
                    ? Container(
                        child: Center(
                          child: Text("Loading....."),
                        ),
                      )
                    : Container(
                        child: _moodposts.length == 0
                            ? Center(
                                child: Text('No Data To Display'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _moodposts.length,
                                controller: _controller,
                                itemBuilder: (context, int index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      height: 270.0,
                                      width: MediaQuery.of(context).size.width,
                                      color:
                                          AppColor.timelinePageContainerColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5.0,
                                          horizontal: 15.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: CircleAvatar(
                                                    radius: 35.0,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      _moodposts[index].data()[
                                                          'postImageUrl'],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _moodposts[index]
                                                            .data()['name'],
                                                        style: AppTextStyles
                                                            .timelinePageNameStyle(),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        timeAgo.format(
                                                          DateTime.parse(
                                                            _moodposts[index]
                                                                    .data()[
                                                                'timeStamp'],
                                                          ),
                                                        ),
                                                        style: AppTextStyles
                                                            .timelinePageTimeStampStyle(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  _moodposts[index]
                                                      .data()['emotion'],
                                                  style: AppTextStyles
                                                      .timelinePageEmotionStyle(),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xffAAAAAA),
                                                    size: 30.0,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0,
                                              ),
                                              child: Container(
                                                height: 100.0,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  _moodposts[index]
                                                      .data()['postMessage'],
                                                  style: AppTextStyles
                                                      .timelinePagePostMessageStyle(),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                userPostBottomBarOptions(
                                                    context,
                                                    icons: Icons
                                                        .question_answer_outlined,
                                                    label: "Video Call"),
                                                userPostBottomBarOptions(
                                                    context,
                                                    icons: Icons.drafts,
                                                    label: "Call Invite"),
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                          context, ChatPage.id),
                                                  child: userPostBottomBarOptions(
                                                      context,
                                                      icons: Icons
                                                          .chat_bubble_outline_outlined,
                                                      label: "Chat"),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget userPostBottomBarOptions(BuildContext context,
    {IconData icons, String label}) {
  return Row(
    children: [
      Icon(
        icons,
        size: 35.0,
        color: AppColor.userPostIconColor,
      ),
      SizedBox(
        width: 5.0,
      ),
      Text(
        label,
        style: AppTextStyles.userPostBottomBarStyle(),
      )
    ],
  );
}
