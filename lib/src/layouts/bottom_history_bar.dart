import 'package:flutter/material.dart';
import 'history_displayer.dart';

class BottomHistoryBar extends StatefulWidget {
  const BottomHistoryBar({Key? key}) : super(key: key);

  @override
  _BottomHistoryBarState createState() => _BottomHistoryBarState();
}

class _BottomHistoryBarState extends State<BottomHistoryBar> {
  bool isHistoryBasOpen = false;
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  late final appBar = AppBar().preferredSize;
  historyBarValue() => isHistoryBasOpen ? height / 1.26 : appBar.height;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColorDark;
    double width = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      curve: Curves.fastLinearToSlowEaseIn,
      height: historyBarValue(),
      width: width,
      bottom: 01,
      duration: const Duration(seconds: 1),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(
          children: [customButton(primaryColor), const HistoryDisplayer()],
        ),
      ),
    );
  }

  TextButton customButton(Color primaryColor) {
    return TextButton(
        onPressed: () {
          setState(() => isHistoryBasOpen = !isHistoryBasOpen);
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'History ',
            style: TextStyle(color: primaryColor, fontSize: 20),
          ),
          if (isHistoryBasOpen)
            Icon(
              Icons.keyboard_arrow_down,
              color: primaryColor,
              size: 30,
            )
          else
            Icon(
              Icons.keyboard_arrow_up,
              color: primaryColor,
              size: 30,
            ),
        ]));
  }
}
