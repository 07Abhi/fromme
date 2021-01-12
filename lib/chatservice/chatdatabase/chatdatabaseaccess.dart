import 'package:cloud_firestore/cloud_firestore.dart';

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
}
