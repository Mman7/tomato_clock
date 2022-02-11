import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';
import '../../providers/tomato_database.dart';
import 'history_tomato_card.dart';

class HistoryDisplayer extends StatelessWidget {
  const HistoryDisplayer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dataBase = context.read<TomatoDataBase>();
    return FutureBuilder<dynamic>(
      initialData: dataBase.fetchData(),
      future: dataBase.fetchData(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) {
          return _tips(context);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 2,
                  ),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var tomatoCount = snapshot.data?[index]['tomatoCount'];
                var date = snapshot.data?[index]['date'];

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TomatoCard(date: date, tomatoCount: tomatoCount),
                );
              });
        } else {
          return _tips(context);
        }
      },
    );
  }

  Center _tips(BuildContext context) {
    return Center(
        child: Text(
      'Try to press the play button',
      style: TextStyle(
          fontSize: ResponsiveFlutter.of(context).fontSize(2.25),
          color: Colors.white.withOpacity(0.8)),
    ));
  }
}
