import 'package:flutter/material.dart';
import 'package:fromme/models/moodpostmodel.dart';
import 'package:fromme/pages/navigation_pages/chatpage.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';
import 'package:timeago/timeago.dart' as timeAgo;

Widget userPostsContainer(BuildContext context, List<MoodPostData> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 270.0,
          width: MediaQuery.of(context).size.width,
          color: AppColor.userPostBackground,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 15.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(data[index].photoUrl),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].name,
                            style: AppTextStyles.userPostNameStyle(),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            timeAgo
                                .format(DateTime.parse(data[index].timeStamp)),
                            style: AppTextStyles.userPostTimeStyle(),
                          )
                        ],
                      ),
                    ),
                    Text(
                      data[index].emotion,
                      style: AppTextStyles.userPostEmotionStyle(),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColor.userPostIconColor,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      data[index].postData,
                      style: AppTextStyles.usePostIndexStyle(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          size: 35.0,
                          color: AppColor.userPostIconColor,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Video Call',
                          style: AppTextStyles.userPostBottomBarStyle(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.drafts,
                          size: 35.0,
                          color: AppColor.userPostIconColor,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Call invite',
                          style: AppTextStyles.userPostBottomBarStyle(),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, ChatPage.id),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_outlined,
                            size: 35.0,
                            color: AppColor.userPostIconColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Chat',
                            style: AppTextStyles.userPostBottomBarStyle(),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
