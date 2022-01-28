import 'package:flutter/material.dart';
import 'history_displayer.dart';

class BottomHistoryBar extends StatefulWidget {
  const BottomHistoryBar({Key? key}) : super(key: key);

  @override
  _BottomHistoryBarState createState() => _BottomHistoryBarState();
}

class _BottomHistoryBarState extends State<BottomHistoryBar> {
  bool isHistoryBasOpen = false;
  late final appBar = AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: DraggableScrollableSheet(
        initialChildSize: 0.1,
        maxChildSize: 0.9,
        minChildSize: 0.1,
        builder: (context, controller) => Container(
          padding: EdgeInsets.symmetric(horizontal: width / 25),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: HistoryDisplayer(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
