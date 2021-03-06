import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';
import 'package:logger/logger.dart';

class TomatoDataBase with ChangeNotifier {
  final _db = Localstore.instance;

  String formatDate(DateTime date) => DateFormat("MMMM d yyyy").format(date);

  Future<dynamic> fetchData() async {
    var items = await _db.collection('tomato').get();
    var parseItem = items?.entries.map((e) => e.value).toList();
    return Future.value(parseItem);
  }

  ///  DEBUG ONLY
  // printAllData() async {
  //   var items = await _db.collection('tomato').get();
  //   print(items);
  // }

  saveTomato() {
    _db
        .collection('tomato')
        .doc(formatDate(DateTime.now()))
        .set({'tomatoCount': 1, 'date': formatDate(DateTime.now())});
    notifyListeners();
  }

  ///  DEBUG ONLY
  // findDataById(DateTime id) async {
  //   var item = await _db.collection('tomato').doc(formatDate(id)).get();
  //   var parseItem = item?.entries.map((e) => e.value);
  // }

  /// id = DateTime.now()
  increaseTomatoData() async {
    var id = formatDate(DateTime.now());
    var item = await _db.collection('tomato').doc(id).get();
    var tomatoCountInData = item?.entries.first.value ?? 0;
    Logger().d(tomatoCountInData);

    _db.collection('tomato').doc(id).set({
      'tomatoCount': tomatoCountInData + 1,
      'date': formatDate(DateTime.now())
    });
    notifyListeners();
  }
}
