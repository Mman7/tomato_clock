import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TomatoCount with ChangeNotifier {
  int _tomatoCount = 0;
  int get tomatoCount => _tomatoCount;

  intialCurrentTomato() async {
    getTomatoCount().then((data) {
      _tomatoCount = data;
      notifyListeners();
    });
  }

  /// value type : int
  saveTomatoCount({databaseName, value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(databaseName, value);
  }

  getTomatoCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('currentTomato');
    return value ?? 0;
  }

  increaseTomatoCount() async {
    _tomatoCount++;
    saveTomatoCount(databaseName: 'currentTomato', value: _tomatoCount);
    notifyListeners();
  }

  cleanTomatoCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tomatoCount = 0;
    prefs.setInt('currentTomato', _tomatoCount);
    notifyListeners();
  }
}
