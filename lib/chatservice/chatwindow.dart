import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/backend_services/chatdatabaseaccess.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_textstyles.dart';

enum chatOptions {
  viewprofile,
  mutenotifications,
  addtobubble,
  sendgift,
  deletegift
}

class ChatWindow extends StatefulWidget {
  static const String id = "/chatwindow";
  final String picUrl;
  final String name;
  final String uid;
  final String myusername;
  final String chatRoomId;
  ChatWindow(
      {this.chatRoomId, this.myusername, this.name, this.picUrl, this.uid});
  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  TextEditingController _messageController = TextEditingController();
  Stream chatMessageStream;
  var selected = chatOptions.viewprofile;

  @override
  void initState() {
    Stream data = DatabaseAccess().getConversationMessages(widget.chatRoomId);
    setState(() {
      chatMessageStream = data;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: AppColor.statusBarColor));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0.0,
          shadowColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: AppColor.chatImageBackgroundColor,
                backgroundImage: NetworkImage(widget.picUrl),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.chatUserTilesNameStyle(),
              )
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.appBarShadowColor2,
                  AppColor.appBarShadowColor1,
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
              color: AppColor.appBarBackButtonColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.video_call_outlined,
                    size: 35.0,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.call,
                    size: 25.0,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {},
                ),
                PopupMenuButton<chatOptions>(
                  // color: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColor.primaryColor,
                    size: 30.0,
                  ),
                  onSelected: (chatOptions data) {
                    setState(() {
                      selected = data;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<chatOptions>>[
                    const PopupMenuItem<chatOptions>(
                      child: Text("View Profile"),
                    ),
                    const PopupMenuItem<chatOptions>(
                      child: Text("Mute Notifications"),
                    ),
                    const PopupMenuItem<chatOptions>(
                      child: Text("Add to Bubble"),
                    ),
                    const PopupMenuItem<chatOptions>(
                      child: Text("Send Gift"),
                    ),
                    const PopupMenuItem<chatOptions>(
                      child: Text("Delete Chat"),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          //chatMessageList(widget.name),
          DatabaseAccess.chatMessageList(widget.myusername, chatMessageStream),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2.0,
                  color: AppColor.chatMessageConatinerBorderColor,
                ),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        keyboardType: TextInputType.name,
                        maxLines: 2,
                        decoration: AppTextStyles
                            .chatMessageContainerTextFieldDecoration(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 30.0,
                        color: Color(0xff42a5f5),
                      ),
                      onPressed: () {
                        DatabaseAccess.sendMessages(context,
                            msg: _messageController.text,
                            myusername: widget.myusername,
                            chatRoomId: widget.chatRoomId);
                        _messageController.clear();
                      },
                    )
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
