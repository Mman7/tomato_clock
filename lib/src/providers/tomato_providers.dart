import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TomatoCount with ChangeNotifier {
  int _tomatoCount = 0;
  late int _focusCountMinute;
  late int _restCountMinute;

  int get tomatoCount => _tomatoCount;
  int get focusCountMinute => _focusCountMinute;
  int get restCountMinute => _restCountMinute;

  intialCurrentTomato() async {
    await getCountingTime(databaseName: 'currentTomato').then((value) {
      _tomatoCount = value ?? 0;
      notifyListeners();
    });
  }

  /// value type : int
  saveCountingTime({databaseName, value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(databaseName, value);
  }

  /// Focus / Rest only
  getCountingTime({databaseName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(databaseName);
    return value;
  }

  increaseTomatoCount() async {
    _tomatoCount++;
    saveCountingTime(databaseName: 'currentTomato', value: _tomatoCount);
    notifyListeners();
  }

  cleanTomatoCount() async {
    _tomatoCount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentTomato', _tomatoCount);
    notifyListeners();
  }
}
