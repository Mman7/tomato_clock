import 'package:flutter/material.dart';

class CurrentStatus with ChangeNotifier {
  // state only focus or rest
  String? _currentStatus;

  String? get status => _currentStatus;

  changeToNullStatus() {
    _currentStatus = null;
    notifyListeners();
  }

  /// String value: focus / rest / null
  changeStatus({required String? value}) {
    _currentStatus = value;
    notifyListeners();
  }
}
