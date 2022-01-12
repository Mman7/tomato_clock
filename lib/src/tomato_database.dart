import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';

class TomatoDataBase with ChangeNotifier {
  //TODO Refactor
  final _db = Localstore.instance;

  String formatDate(DateTime date) => DateFormat("MMMM d yyyy").format(date);

  //TODO Change todos to tomatoWithDate
  Future<dynamic> fetchData() async {
    var items = await _db.collection('todos').get();
    var parseItem = items?.entries.map((e) => e.value).toList();
    return Future.value(parseItem);
  }

  printAllData() async {
    var items = await _db.collection('todos').get();
    print(items);
  }

  saveTomato() {
    _db
        .collection('todos')
        .doc(formatDate(DateTime.now()))
        .set({'tomatoCount': 1, 'date': formatDate(DateTime.now())});
    print('saved');
    notifyListeners();
  }

  findDataById(DateTime id) async {
    var item = await _db.collection('todos').doc(formatDate(id)).get();
    var parseItem = item?.entries.map((e) => e.value);
    print(parseItem);
  }

  /// id = DateTime.now()
  increaseTomatoData() async {
    var id = formatDate(DateTime.now());
    var item = await _db.collection('todos').doc(id).get();
    var tomatoCountInData = item?.entries.first.value;

    if (tomatoCountInData == null) {
      saveTomato();
    } else {
      _db.collection('todos').doc(id).delete();
      _db.collection('todos').doc(id).set({
        'tomatoCount': tomatoCountInData + 1,
        'date': formatDate(DateTime.now())
      });
    }
    print('increased tomato from database');
    notifyListeners();
  }
}
