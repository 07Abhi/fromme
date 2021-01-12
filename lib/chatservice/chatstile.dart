import 'package:flutter/material.dart';
import 'package:fromme/chatservice/chatdatabase/chatdatabaseaccess.dart';
import 'package:fromme/chatservice/chatwindow.dart';

class ChatTiles extends StatefulWidget {
  String imgUrl;
  String name;
  String uid;
  bool isOnline;
  String currentUserName;
  String currentUserEmail;
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
  createChatRoomAndDatabase(String username) async {
    String chatRoomId = DatabaseAccess().getChatRoomId(
        username.replaceAll(" ", ""),
        widget.currentUserName.replaceAll(" ", ""));
    List<String> users = [username, widget.currentUserName];
    Map<String, dynamic> chatDb = {
      "users": users,
      "chatRoomid": chatRoomId,
    };
    DatabaseAccess().createChatRoom(chatRoomId, chatDb);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatWindow(
          picUrl: widget.imgUrl,
          uid: widget.uid,
          name: widget.name,
          myusername: widget.currentUserName,
          chatRoomId: chatRoomId,
        ),
      ),
    );
  }

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
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      size: 20.0,
                      color: widget.isOnline ? Colors.green : Colors.red,
                    ),
                    Text(
                      widget.isOnline ? "Online" : "Not Active",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
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
                createChatRoomAndDatabase(widget.name);
              },
              child: Text(
                'Message',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
