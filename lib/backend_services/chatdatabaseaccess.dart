import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fromme/chatservice/chatwindow.dart';
import 'package:fromme/chatservice/searchresult.dart';
import 'package:fromme/utilities/app_colors.dart';
import 'package:fromme/utilities/app_constant_widgets.dart';
import 'package:fromme/widgets/message_tiles.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DatabaseAccess {
  getUserByNameSearch(String username) async {
    return await _firestore
        .collection('userdata')
        .where('name', isEqualTo: username)
        .get();
  }

  getUserByEmailSearch(String emailAdd) async {
    return await _firestore
        .collection('userdata')
        .where('email', isEqualTo: emailAdd)
        .get();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom(String chatRoomId, userDataMap) {
    _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .set(userDataMap)
        .catchError((e) {
      print(e.message);
    });
  }

  sendChatMessages(String chatRoomId, messageMap) {
    _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.message);
    });
  }

  getConversationMessages(String chatRoomId) {
    return _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  static checkSearchResults(BuildContext context, String username) async {
    QuerySnapshot data = await DatabaseAccess().getUserByNameSearch(username);

    SystemChannels.textInput.invokeMethod("TextInput.hide");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(
          searchResults: data,
        ),
      ),
    );
  }

  static createChatRoomAndDatabase(
    BuildContext context, {
    String username,
    String currentUserName,
    String imgUrl,
    String uid,
  }) async {
    String chatRoomId = DatabaseAccess().getChatRoomId(
        username.replaceAll(" ", ""), currentUserName.replaceAll(" ", ""));
    List<String> users = [username, currentUserName];
    Map<String, dynamic> chatDb = {
      "users": users,
      "chatRoomid": chatRoomId,
    };
    DatabaseAccess().createChatRoom(chatRoomId, chatDb);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatWindow(
          picUrl: imgUrl,
          uid: uid,
          name: username,
          myusername: currentUserName,
          chatRoomId: chatRoomId,
        ),
      ),
    );
  }

  static Widget chatMessageList(String username, Stream chatMessageStream) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessageStream,
      builder: (context, asynSnapshot) {
        if (!asynSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColor.circularProgressIndiColor,
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

  static sendMessages(BuildContext context,
      {String msg, String myusername, String chatRoomId}) {
    if (msg.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": msg,
        "sendBy": myusername,
        "timeStamp": DateTime.now().millisecondsSinceEpoch
      };
      DatabaseAccess().sendChatMessages(chatRoomId, messageMap);
      //_messageController.clear();
    } else {
      AppConstantsWidgets.appToastDisplay(context, info: "Empty Message");
    }
  }
}
