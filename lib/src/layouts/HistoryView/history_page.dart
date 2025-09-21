import 'package:flutter/material.dart';
import 'package:tomato_clock/src/layouts/HistoryView/history_tomato_card.dart';
import '../../Database/tomato_database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List data = [];
  @override
  void initState() {
    TomatoDataBase.fetchData().then((value) => setState(() => data = value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'History',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.grey[100],
          child: ListView.builder(
              controller: widget.scrollController,
              padding: EdgeInsets.zero,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var tomatoCount = data[index]['tomatoCount'];
                var date = data[index]['date'];

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TomatoCard(date: date, tomatoCount: tomatoCount),
                );
              }),
        ));
  }
}
