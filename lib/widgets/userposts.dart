import 'package:flutter/material.dart';

Widget userPostsContainer(BuildContext context) {
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
                    backgroundImage: AssetImage('assets/userlogo.png'),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Name",
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
                        "x min ago",
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
                  "Emotion",
                  style: TextStyle(
                    fontSize: 22.0,
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "My Favourite childhood was working on a start up that i think is good to kick ass! Click this post to send me a message i'll share some more details ;)",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
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
                Row(
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
              ],
            )
          ],
        ),
      ),
    ),
  );
}