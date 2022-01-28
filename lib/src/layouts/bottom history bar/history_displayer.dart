import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../providers/tomato_providers.dart';
import '../../providers/tomato_database.dart';
import '../custom_gradient_background.dart';
import 'history_tomato_card.dart';

class HistoryDisplayer extends StatefulWidget {
  const HistoryDisplayer({Key? key, required this.controller})
      : super(key: key);
  final controller;
  @override
  State<HistoryDisplayer> createState() => _HistoryDisplayerState();
}

class _HistoryDisplayerState extends State<HistoryDisplayer> {
  late Future _getdata;
  @override
  void initState() {
    super.initState();
    _getdata = context.read<TomatoDataBase>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    context.read<TomatoCount>().addListener(() {
      setState(() {});
    });
    return FutureBuilder<dynamic>(
      future: _getdata,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) return Container();
        if (snapshot.hasData) {
          return ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const Divider(
                    height: 30,
                    thickness: 2,
                  ),
              controller: widget.controller,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                if (snapshot.data == null) return Container();
                var tomatoCount = snapshot.data?[index]['tomatoCount'];
                var date = snapshot.data?[index]['date'];
                if (index == 0) {
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: height / 100),
                    leading: Text(
                      'History Bar',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorDark,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.75)),
                    ),
                    trailing: Icon(
                      Icons.drag_handle,
                      size: ResponsiveFlutter.of(context).fontSize(3.75),
                      color: Theme.of(context).primaryColorDark,
                    ),
                  );
                }
                return Column(
                  children: [
                    CustomGradientBackground(
                      firstColor: "#88FFA7",
                      secondColor: '#3A754A',
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: TomatoCard(date: date, tomatoCount: tomatoCount),
                    ),
                  ],
                );
              });
        } else {
          return ListView();
        }
      },
    );
  }
}
