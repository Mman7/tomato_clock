import 'package:shared_preferences/shared_preferences.dart';

class CountTime {
  // seconds
  static const _defaultFocusTime = 900;
  static const _restCountTime = 300;

  /// [databaseName] = FocusCountTime / RestCountTime
  static saveTimer(
      {required String databaseName, required int countTime}) async {
    var database = await SharedPreferences.getInstance();
    await database.setInt(databaseName, countTime);
  }

  static _defaultTime(databaseName) =>
      databaseName == 'Focus' ? _defaultFocusTime : _restCountTime;

  /// [databaseName] = FocusCountTime / RestCountTime
  static Future<int> getTimer({required String databaseName}) async {
    final database = await SharedPreferences.getInstance();
    int? data = database.getInt(databaseName) ?? _defaultTime(databaseName);
    return data as int;
  }
}
