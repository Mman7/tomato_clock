import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TomatoCount with ChangeNotifier {
  int _tomatoCount = 0;
  late int _focusCountMinute;
  late int _restCountMinute;

  int get tomatoCount => _tomatoCount;
  int get focusCountMinute => _focusCountMinute;
  int get restCountMinute => _restCountMinute;

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

  increaseTomatoCount() {
    _tomatoCount++;
    notifyListeners();
  }

  cleanTomatoCount() {
    _tomatoCount = 0;
    notifyListeners();
  }
}
