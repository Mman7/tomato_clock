import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';

class TomatoDataBase {
  static String formatDate(DateTime date) =>
      DateFormat("MMMM d yyyy").format(date);

  static Future<dynamic> fetchData() async {
    final _db = Localstore.instance;
    var items = await _db.collection('tomato').get();
    var parseItem = items?.entries.map((e) => e.value).toList();
    return Future.value(parseItem);
  }

  static saveTomato() {
    final _db = Localstore.instance;
    _db
        .collection('tomato')
        .doc(formatDate(DateTime.now()))
        .set({'tomatoCount': 1, 'date': formatDate(DateTime.now())});
  }

  static addNewTomatoData() async {
    final _db = Localstore.instance;
    var id = formatDate(DateTime.now());
    var item = await _db.collection('tomato').doc(id).get();
    var tomatoCountInData = item?.entries.first.value ?? 0;

    _db.collection('tomato').doc(id).set({
      'tomatoCount': tomatoCountInData + 1,
      'date': formatDate(DateTime.now())
    });
  }
}
