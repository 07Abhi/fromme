import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

final String serverToken =
    'AAAATCduRFw:APA91bFgpQwxfftgmQQb15RIO1RLzLeAoGztAyUlKlm6cj4bO8CdwVDLqwBrhKSl-jpqxMEEIi2WxyqxJPSZQcUICZmcXii75okBZkapF70uUToRbVYjek0oUngjsZiE6k_lNztFKy9s';
FirebaseMessaging _messaging = FirebaseMessaging();
Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('on background $message');
}

sendAndRetrieveMessage(String deviceToken,
    {String title, String message}) async {
  print("Inside notification function");
  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': message,
          'title': title,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': deviceToken,
      },
    ),
  );
  _messaging.configure(
    onMessage: (message) async {
      print("inside on message");
      print(message['notification']['title']);
      print(message['notification']['body']);
      return;
    },
    onLaunch: (msg) {
      print(msg);
      return;
    },
    onResume: (msg) {
      print(msg);
      return;
    },
    onBackgroundMessage: myBackgroundMessageHandler,
  );
}
