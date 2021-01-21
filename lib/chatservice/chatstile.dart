import 'package:flutter/material.dart';
import 'package:fromme/backend_services/chatdatabaseaccess.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';

class ChatTiles extends StatefulWidget {
  final String imgUrl;
  final String name;
  final String uid;
  final bool isOnline;
  final String currentUserName;
  final String currentUserEmail;
  ChatTiles(
      {this.imgUrl,
      this.isOnline,
      this.name,
      this.uid,
      this.currentUserName,
      this.currentUserEmail});

  @override
  _ChatTilesState createState() => _ChatTilesState();
}

class _ChatTilesState extends State<ChatTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              radius: 45.0,
              backgroundImage: NetworkImage(widget.imgUrl),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: AppTextStyles.chatTileNameStyle(),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      size: 20.0,
                      color: widget.isOnline
                          ? AppColor.isOnlineColorIndicator
                          : AppColor.isOfflineColorIndicator,
                    ),
                    Text(
                      widget.isOnline ? "Online" : "Not Active",
                      style: AppTextStyles.chatUserActiveStatusStyle(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: FlatButton(
              onPressed: () {
                DatabaseAccess.createChatRoomAndDatabase(context,
                    username: widget.name,
                    currentUserName: widget.currentUserName,
                    uid: widget.uid,
                    imgUrl: widget.imgUrl);
              },
              child: Text(
                'Message',
                style: AppTextStyles.chatTileMsgBtnTextStyle(),
              ),
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
