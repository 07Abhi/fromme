import 'package:flutter/material.dart';

class MoodManager extends ChangeNotifier {
  String mood;
  void applyMood(String val) {
    mood = val;
  }

  String getMood() {
    return mood;
  }
}
