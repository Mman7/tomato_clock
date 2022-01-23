import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';

class CountDownTimer extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CountDownTimer(
      {Key? key,
      this.seconds = 20,
      required this.onFinish,
      required this.onStart,
      required this.databaseName});
  final int seconds;
  final VoidCallback onFinish;
  final VoidCallback onStart;
  final String databaseName;
  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? timer;
  late int maxSeconds = widget.seconds; // widget.seconds
  late int seconds = maxSeconds;
  late final countingDatabase = context.read<TomatoCount>();
  late final currentStatus = context.read<CurrentStatus>();
  late final databaseName = widget.databaseName.toLowerCase();
  @override
  void initState() {
    super.initState();
    context
        .read<TomatoCount>()
        .getCountingTime(databaseName: databaseName)
        .then((value) => setState(() {
              maxSeconds = value ?? maxSeconds;
              seconds = value ?? maxSeconds;
            }));
    Future.delayed(const Duration(milliseconds: 1), () => resetTimer());
  }

  increaseTime() {
    setState(() => {seconds += 60, maxSeconds += 60});
    countingDatabase.saveCountingTime(
        databaseName: databaseName, value: maxSeconds);
  }

  decreaseTime() {
    if (seconds == 0 || seconds.isNegative || seconds < 120) return;
    setState(() => {
          maxSeconds -= 60,
          seconds -= 60,
        });
    countingDatabase.saveCountingTime(
        databaseName: databaseName, value: maxSeconds);
  }

  secondsToMinutes({required seconds}) {
    getParsedTime(String time) => time.length <= 1 ? '0$time' : time;
    var min = seconds ~/ 60;
    var sec = (seconds % 60).truncate();
    if (seconds < 0) sec = seconds.truncate();
    return '${getParsedTime(min.toString())}:${getParsedTime(sec.toString())}';
  }

  playTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) return;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
      });
      print('time checking $seconds');
      if (seconds <= 0 || seconds.isNegative) timesUp();
    });
    currentStatus.changeStatus(value: databaseName);
  }

  pauseTimer() {
    timer?.cancel();
    () => widget.onStart();
  }

  resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = maxSeconds;
    });
    currentStatus.changeToNullStatus();
  }

  timesUp() {
    timer?.cancel();
    setState(() {
      seconds = maxSeconds;
      widget.onFinish();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Color? themePrimaryColor = Theme.of(context).textTheme.bodyText1?.color;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () => increaseTime(),
                  padding: const EdgeInsets.all(3),
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.add_circle,
                    color: themePrimaryColor,
                  )),
            ),
            Text(
              '${secondsToMinutes(seconds: seconds)}',
              style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(3),
                  color: themePrimaryColor,
                  fontWeight: FontWeight.w700),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                  padding: const EdgeInsets.all(3),
                  constraints: const BoxConstraints(),
                  onPressed: () => decreaseTime(),
                  icon: Icon(
                    Icons.remove_circle,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  )),
            ),
          ],
        ),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customIconButton(
                  context: context,
                  icon: Icons.play_arrow_rounded,
                  callback: () => playTimer(),
                ),
                customIconButton(
                  context: context,
                  icon: Icons.pause,
                  callback: () => pauseTimer(),
                ),
                customIconButton(
                  context: context,
                  icon: Icons.restore,
                  callback: () => resetTimer(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Material customIconButton(
      {required BuildContext context,
      required IconData icon,
      required VoidCallback callback}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
          alignment: Alignment.center,
          onPressed: () => callback(),
          icon: Icon(
            icon,
            color: Theme.of(context).textTheme.bodyText1?.color,
            size: 35,
          )),
    );
  }
}
