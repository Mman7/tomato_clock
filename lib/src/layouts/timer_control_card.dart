import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../count_down_timer.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 25),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 5),
                spreadRadius: 1,
                blurRadius: 4)
          ],
          color: HexColor('#E5FFEC'),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: themePrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          CountDownTimer(
            onFinish: onFinish,
            onStart: onStart,
            seconds: minuteToSeconds(countMinute),
          ),
        ],
      ),
    );
  }
}
