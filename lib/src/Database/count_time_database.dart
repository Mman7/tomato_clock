import 'package:shared_preferences/shared_preferences.dart';

class CountTime {
  /// [databaseName] = FocusCountTime / RestCountTime
  static saveTimer({required String databaseName, countTime}) async {
    var database = await SharedPreferences.getInstance();
    await database.setInt('${databaseName}CountTime', countTime);
  }

  /// [databaseName] = FocusCountTime / RestCountTime
  static getTimer({databaseName}) async {
    final database = await SharedPreferences.getInstance();
    final data = database.getInt('${databaseName}CountTime');
    const defaultFocusTime = 25;
    const restCountTime = 5;
    if (databaseName == 'Focus') return data ?? defaultFocusTime;
    if (databaseName == 'Rest') return data ?? restCountTime;
  }
}
