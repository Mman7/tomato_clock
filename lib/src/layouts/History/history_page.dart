import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:tomato_clock/src/layouts/custom_gradient_background.dart';
import '../../providers/tomato_database.dart';
import 'history_displayer.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => TomatoDataBase())],
        child: Scaffold(
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
                child: const HistoryDisplayer())));
  }
}
