import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:tomato_clock/src/notification.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';

/// DOC: https://pub.dev/packages/timer_count_down

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
  final CountdownController _controller = CountdownController();
  late int seconds = widget.seconds;
  late final countingDatabase = context.read<TomatoCount>();

  @override
  void initState() {
    super.initState();
    context
        .read<TomatoCount>()
        .getCountingTime(databaseName: widget.databaseName)
        .then((value) => setState(() {
              seconds = value ?? widget.seconds;
            }));
  }

  increaseTime() {
    setState(() => seconds += 60);
    countingDatabase.saveCountingTime(
        databaseName: widget.databaseName, value: seconds);
  }

  decreaseTime() {
    if (seconds == 0 || seconds.isNegative || seconds < 120) return;
    setState(() => seconds -= 60);
    countingDatabase.saveCountingTime(
        databaseName: widget.databaseName, value: seconds);
  }

  secondsToMinutes({required double seconds}) {
    getParsedTime(String time) => time.length <= 1 ? '0$time' : time;
    var formatedTimeMinute = seconds ~/ 60;
    var formatedTimeSeconds = (seconds % 60).truncate();

    return '${getParsedTime(formatedTimeMinute.toString())}:${getParsedTime(formatedTimeSeconds.toString())}';
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
            Countdown(
              controller: _controller,
              seconds: seconds,
              build: (BuildContext context, double time) => Text(
                secondsToMinutes(seconds: time).toString(),
                style: TextStyle(
                    color: themePrimaryColor,
                    fontSize: 6.5.w,
                    fontWeight: FontWeight.w700),
              ),
              interval: const Duration(milliseconds: 100),
              onFinished: () {
                _controller.restart();
                _controller.pause();
                widget.onFinish();
                context.read<NotificationService>().instantNotification();
              },
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customIconButton(
              context: context,
              icon: Icons.play_arrow_rounded,
              callback: () {
                widget.onStart();
                _controller.start();
              },
            ),
            customIconButton(
              context: context,
              icon: Icons.pause,
              callback: () => _controller.pause(),
            ),
            customIconButton(
              context: context,
              icon: Icons.restore,
              callback: () => {
                _controller.restart(),
                _controller.pause(),
                context.read<CurrentStatus>().changeStatus(value: null)
              },
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
