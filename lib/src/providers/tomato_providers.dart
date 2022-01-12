import 'package:flutter/material.dart';

class TomatoCount with ChangeNotifier {
  int _tomatoCount = 0;

  int get tomatoCount => _tomatoCount;

  increaseTomatoCount() {
    _tomatoCount++;

    notifyListeners();
  }

  addTomatoCountToHistory() {}

  cleanTomatoCount() {
    _tomatoCount = 0;
    notifyListeners();
  }
}
