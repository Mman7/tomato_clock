import 'package:shared_preferences/shared_preferences.dart';

class CountTime {
  static const _defaultFocusTime = 25;
  static const _restCountTime = 5;

  /// [databaseName] = FocusCountTime / RestCountTime
  static saveTimer(
      {required String databaseName, required int countTime}) async {
    var database = await SharedPreferences.getInstance();
    await database.setInt(databaseName, countTime);
  }

  static _defaultTime(databaseName) =>
      databaseName == 'focus' ? _defaultFocusTime : _restCountTime;

  /// [databaseName] = FocusCountTime / RestCountTime
  static Future<int> getTimer({required String databaseName}) async {
    final database = await SharedPreferences.getInstance();
    int? data = database.getInt(databaseName) ?? _defaultTime(databaseName);
    return data as int;
  }
}
