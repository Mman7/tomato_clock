import 'package:flutter/material.dart';

class TomatoCount with ChangeNotifier {
  int _tomatoCount = 0;

  int get tomatoCount => _tomatoCount;

  increaseTomatoCount() {
    print('completed 1 tomato now rest');
    _tomatoCount++;
    if (_tomatoCount == 4) restTimeNow();
    //TODO Add tomato to history
    // history need to save
    //
    notifyListeners();
  }

  _cleanTomatoCount() {
    _tomatoCount = 0;
    notifyListeners();
  }

  restTimeNow() {
    print('ITS REST TIME BITCH');
    _cleanTomatoCount();
    notifyListeners();
  }
}
