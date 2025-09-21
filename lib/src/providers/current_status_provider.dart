import 'package:flutter/material.dart';

enum CurrentTimer { focus, rest, none }

class CurrentStatus with ChangeNotifier {
  // state only focus or rest
  CurrentStatus() {
    _currentStatus = CurrentTimer.none;
  }
  CurrentTimer? _currentStatus;

  CurrentTimer? get status => _currentStatus;

  changeToNullStatus() {
    _currentStatus = CurrentTimer.none;
    notifyListeners();
  }

  changeStatus({required CurrentTimer value}) {
    _currentStatus = value;
    notifyListeners();
  }
}
