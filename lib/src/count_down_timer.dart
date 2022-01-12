import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:tomato_clock/src/notification.dart';

/// DOC: https://pub.dev/packages/timer_count_down

class CountDownTimer extends StatefulWidget {
  const CountDownTimer(
      {Key? key,
      this.seconds = 20,
      required this.onFinish,
      required this.onStart});
  final int seconds;
  final VoidCallback onFinish;
  final VoidCallback onStart;
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
    setState(() => seconds += 60);
  }

  decreaseTime() {
    if (seconds == 0 || seconds.isNegative || seconds < 120) return;
    setState(() => seconds -= 60);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              child: IconButton(
                  onPressed: () => increaseTime(),
                  icon: Icon(
                    Icons.add_circle,
                    color: themePrimaryColor,
                  )),
            ),
            Countdown(
              controller: _controller,
              //! DEV HERE
              // TODO Change here later: change to [seconds] when release
              seconds: seconds,
              build: (BuildContext context, double time) => Text(
                '${secondsToMinutes(seconds: time)}',
                style: TextStyle(
                    color: themePrimaryColor,
                    fontSize: 25,
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
              child: IconButton(
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
              callback: () => {_controller.restart(), _controller.pause()},
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
      child: IconButton(
          alignment: Alignment.center,
          onPressed: () => callback(),
          // padding: EdgeInsets.zero,
          // constraints: BoxConstraints(),
          icon: Icon(
            icon,
            color: Theme.of(context).textTheme.bodyText1?.color,
            size: 35,
          )),
    );
  }
}
