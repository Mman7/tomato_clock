import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../utils/count_down_timer.dart';

class TimerControlCard extends StatelessWidget {
  const TimerControlCard(
      {Key? key,
      required this.title,
      required this.countMinute,
      required this.onFinish,
      required this.onStart})
      : super(key: key);
  final String title;
  final int countMinute;
  final VoidCallback onFinish;
  final VoidCallback onStart;
  minuteToSeconds(minute) => Duration(minutes: minute).inSeconds;

  @override
  Widget build(BuildContext context) {
    Color? themePrimaryColor = Theme.of(context).textTheme.bodyText1?.color;
    final width = MediaQuery.of(context).size.width;
    // !FIX LAYOUT HERE
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 150, vertical: width / 18),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: themePrimaryColor,
                fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          CountDownTimer(
            databaseName: title,
            onFinish: onFinish,
            onStart: onStart,
            seconds: minuteToSeconds(countMinute),
          ),
        ],
      ),
    );
  }
}
