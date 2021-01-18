import 'package:flutter/material.dart';
import 'package:fromme/models/moodpostmodel.dart';
import 'package:fromme/pages/navigation_pages/chatpage.dart';
import 'package:timeago/timeago.dart' as timeAgo;

Widget userPostsContainer(BuildContext context, List<MoodPostData> data) {
  final tenAgo = new DateTime.now();

  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 270.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
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
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            timeAgo
                                .format(DateTime.parse(data[index].timeStamp)),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff555555),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      data[index].emotion,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff27AE60),
                      ),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      data[index].postData,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
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
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Video Call',
                          style: TextStyle(
                            color: Color(0xff595959),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.drafts,
                          size: 35.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Call invite',
                          style: TextStyle(
                            color: Color(0xff595959),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
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
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                              color: Color(0xff595959),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
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
