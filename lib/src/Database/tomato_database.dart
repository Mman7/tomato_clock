import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';

class TomatoDataBase {
  static final _db = Localstore.instance;
  static String formatDate(DateTime date) =>
      DateFormat("MMMM d yyyy").format(date);

  static Future<List> fetchData() async {
    dynamic items = await _db.collection('tomato').get();
    if (items == null) return [];
    var parseItem = items?.entries.map((e) => e.value);
    return Future.value(parseItem);
  }

  static saveTomato() {
    _db
        .collection('tomato')
        .doc(formatDate(DateTime.now()))
        .set({'tomatoCount': 1, 'date': formatDate(DateTime.now())});
  }

  static addNewTomatoData() async {
    var id = formatDate(DateTime.now());
    var item = await _db.collection('tomato').doc(id).get();
    var tomatoCountInData = item?.entries.first.value ?? 0;

    _db.collection('tomato').doc(id).set({
      'tomatoCount': tomatoCountInData + 1,
      'date': formatDate(DateTime.now())
    });
  }
}
