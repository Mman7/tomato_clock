import 'package:flutter/material.dart';
import 'package:tomato_clock/src/layouts/CustomWidget/custom_gradient_background.dart';
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
  var data;
  @override
  void initState() {
    TomatoDataBase.fetchData().then((value) => setState(() {
          data = value;
        }));

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
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: CustomGradientBackground(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            firstColor: '#88FFA7',
            secondColor: '#3A754A',
            child: ListView.builder(
                controller: widget.scrollController,
                padding: EdgeInsets.zero,
                itemCount: data?.length ?? 1,
                itemBuilder: (context, index) {
                  if (data == null) return _tips(context);
                  var tomatoCount = data[index]['tomatoCount'];
                  var date = data[index]['date'];

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TomatoCard(date: date, tomatoCount: tomatoCount),
                  );
                })));
  }

  _tips(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 100),
      child: Center(
          child: Text(
        'Try to press the play button!',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
      )),
    );
  }
}
