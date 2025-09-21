import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';

class TomatoDataBase {
  static final Localstore _db = Localstore.instance;
  static String _formatDate(DateTime date) =>
      DateFormat("MMMM d yyyy").format(date);

  static Future<List> fetchData() async {
    dynamic tomatoCollection = await _db.collection('tomato').get();
    if (tomatoCollection == null) return [];
    List parseItem = tomatoCollection.entries.map((e) => e.value).toList();
    return parseItem;
  }

  static saveTomato() {
    _db
        .collection('tomato')
        .doc('${DateTime.now()}')
        .set({'tomatoCount': 1, 'date': _formatDate(DateTime.now())});
  }

  static addNewTomatoData() async {
    // get today
    String id = _formatDate(DateTime.now());
    var item = await _db.collection('tomato').doc(id).get();
    var tomatoCountInData = item?.entries.first.value ?? 0;

    _db.collection('tomato').doc(id).set({
      'tomatoCount': tomatoCountInData + 1,
      'date': _formatDate(DateTime.now())
    });
  }
}
