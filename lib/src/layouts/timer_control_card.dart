import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../count_down_timer.dart';

class TimerControlCard extends StatelessWidget {
  TimerControlCard({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    Color? themePrimaryColor = Theme.of(context).textTheme.bodyText1?.color;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            CountDownTimer(
              seconds: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customIconButton(context, Icons.play_arrow_rounded),
                  customIconButton(context, Icons.pause),
                  customIconButton(context, Icons.restore),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  IconButton customIconButton(BuildContext context, IconData icon) {
    return IconButton(
        onPressed: () {},
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Icon(
          icon,
          color: Theme.of(context).textTheme.bodyText1?.color,
          size: 37,
        ));
  }
}
