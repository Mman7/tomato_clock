import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';

class TomatoDataBase {
  static final Localstore _db = Localstore.instance;
  static const String collectionName = 'tomato';
  static final String todayID = _formatDate(DateTime.now());

  static String _formatDate(DateTime date) =>
      DateFormat('MM-dd-yyyy - EEEE').format(date);

  static Future<List> fetchDataList() async {
    // _db.collection(collectionName).delete();
    var doc = await _db.collection(collectionName).get();
    if (doc == null) return [];
    List parseItem = doc.entries.map((e) => e.value).toList();
    return parseItem;
  }

  static saveTomato() {
    _db
        .collection(collectionName)
        .doc(todayID)
        .set({'tomatoCount': 1, 'date': _formatDate(DateTime.now())});
  }

  static increaseTomato() async {
    var doc = await _db.collection(collectionName).doc(todayID).get();

    // if doc cant be found create a new one
    if (doc == null) saveTomato();

    // check tomato Count
    int defaultCount = doc?['tomatoCount'] ?? 0;
    int tomatoCount = defaultCount + 1;

    _db
        .collection(collectionName)
        .doc(todayID)
        .set({'tomatoCount': tomatoCount, 'date': _formatDate(DateTime.now())});
  }
}
