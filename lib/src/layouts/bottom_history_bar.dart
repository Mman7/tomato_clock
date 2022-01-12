import 'package:flutter/material.dart';
import 'history_displayer.dart';

// TODO Finish Here and find a to get data & save data

class BottomHistoryBar extends StatefulWidget {
  const BottomHistoryBar({Key? key}) : super(key: key);

  @override
  _BottomHistoryBarState createState() => _BottomHistoryBarState();
}

class _BottomHistoryBarState extends State<BottomHistoryBar> {
  bool isHistoryBasOpen = false;
  historyBarValue() => isHistoryBasOpen
      ? MediaQuery.of(context).size.height / 10
      : MediaQuery.of(context).size.height / 1.27;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColorDark;
    return AnimatedPositioned(
      curve: Curves.fastLinearToSlowEaseIn,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      top: historyBarValue(),
      duration: const Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: Column(
            children: [CustomButton(primaryColor), const HistoryDisplayer()],
          ),
        ),
      ),
    );
  }

  TextButton CustomButton(Color primaryColor) {
    return TextButton(
        onPressed: () {
          setState(() => isHistoryBasOpen = !isHistoryBasOpen);
        },
        child: Row(
          children: [
            Text(
              'History ',
              style: TextStyle(color: primaryColor, fontSize: 20),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: primaryColor,
              size: 30,
            )
          ],
        ));
  }
}
