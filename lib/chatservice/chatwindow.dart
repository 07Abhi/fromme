import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/chatservice/chatdatabase/chatdatabaseaccess.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toast/toast.dart';

enum chatOptions {
  viewprofile,
  mutenotifications,
  addtobubble,
  sendgift,
  deletegift
}

class ChatWindow extends StatefulWidget {
  static const String id = "/chatwindow";
  String picUrl;
  String name;
  String uid;
  String myusername;
  String chatRoomId;
  ChatWindow(
      {this.chatRoomId, this.myusername, this.name, this.picUrl, this.uid});
  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  TextEditingController _messageController = TextEditingController();
  Stream chatMessageStream;
  var _selected = chatOptions.viewprofile;

  Widget chatMessageList(String username) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessageStream,
      builder: (context, asynSnapshot) {
        if (!asynSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white54,
              strokeWidth: 5.0,
            ),
          );
        }
        return ListView.builder(
          itemCount: asynSnapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTiles(
              msg: asynSnapshot.data.docs[index].data()['message'],
              isMe: asynSnapshot.data.docs[index].data()['sendBy'] == username,
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    Stream data = DatabaseAccess().getConversationMessages(widget.chatRoomId);
    setState(() {
      chatMessageStream = data;
    });

    super.initState();
  }

  sendMessages() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _messageController.text,
        "sendBy": widget.myusername,
        "timeStamp": DateTime.now().millisecondsSinceEpoch
      };
      DatabaseAccess().sendChatMessages(widget.chatRoomId, messageMap);
      _messageController.clear();
    } else {
      Toast.show("Empty Message", context,
          duration: 1,
          gravity: Toast.BOTTOM,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
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
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(widget.picUrl),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
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
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.video_call_outlined,
                    size: 35.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.call,
                    size: 25.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                PopupMenuButton<chatOptions>(
                  // color: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).primaryColor,
                    size: 30.0,
                  ),
                  onSelected: (chatOptions data) {
                    setState(() {
                      _selected = data;
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
          chatMessageList(widget.myusername),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2.0,
                  color: Color(0xff42a5f5),
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
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffbbdefb),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffbbdefb),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.chat,
                            color: Color(0xff42a5f5),
                            size: 30.0,
                          ),
                          hintText: 'Type Message....',
                          hintStyle: TextStyle(
                            color: Color(0xff1976d2),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 30.0,
                        color: Color(0xff42a5f5),
                      ),
                      onPressed: () {
                        sendMessages();
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

class MessageTiles extends StatelessWidget {
  final String msg;
  final bool isMe;
  MessageTiles({this.msg, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isMe ? 0 : 24.0, right: isMe ? 24 : 0, top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15),
        height: 50.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isMe
                ? [
                    Color(0xff81d4fa),
                    Color(0xff4fc3f7),
                  ]
                : [
                    Color(0xfff48fb1),
                    Color(0xfff06292),
                  ],
          ),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
