import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';

/// DOC: https://pub.dev/packages/timer_count_down

class CountDownTimer extends StatefulWidget {
  CountDownTimer({this.seconds = 20, Key? key});
  int seconds;

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  final CountdownController _controller = CountdownController();
  late int seconds;
  @override
  void initState() {
    super.initState();
    seconds = widget.seconds;
  }

  increaseTime() {
    setState(() {
      seconds += 5;
    });
  }

  decreaseTime() {
    if (seconds == 0 || seconds.isNegative) return;
    setState(() {
      seconds -= 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? themePrimaryColor = Theme.of(context).textTheme.bodyText1?.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => increaseTime(),
            icon: Icon(
              Icons.add_circle,
              color: themePrimaryColor,
            )),
        Countdown(
          controller: _controller,
          seconds: seconds,
          build: (BuildContext context, double time) => Text(
            '$time',
            style: TextStyle(
                color: themePrimaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          interval: const Duration(milliseconds: 100),
          onFinished: () {
            print('Timer is done!');
          },
        ),
        IconButton(
            onPressed: () => decreaseTime(),
            icon: Icon(
              Icons.remove_circle,
              color: Theme.of(context).textTheme.bodyText1?.color,
            )),
      ],
    );
  }
}
