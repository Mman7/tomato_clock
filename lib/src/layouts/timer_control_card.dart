import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:tomato_clock/src/Database/count_time_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';

class TimerControlCard extends StatefulWidget {
  const TimerControlCard(
      {Key? key,
      required this.title,
      required this.onFinish,
      required this.onStart})
      : super(key: key);
  final String title;
  final VoidCallback onFinish;
  final VoidCallback onStart;

  @override
  State<TimerControlCard> createState() => _TimerControlCardState();
}

class _TimerControlCardState extends State<TimerControlCard> {
  Duration _duration = const Duration(seconds: 0);
  final timerController = CountdownController();

  @override
  void initState() {
    // initialize timer
    CountTime.getTimer(databaseName: widget.title)
        .then((value) => setState(() => _duration = Duration(seconds: value)));

    super.initState();
  }

  String formatDuration(double time) {
    Duration duration = Duration(seconds: time.toInt());
    // if min or second is one character add a zero infront of it
    String mins = '${duration.inMinutes}';
    String formatMins = mins.length > 1 ? mins : '0$mins';
    String seconds = '${duration.inSeconds % 60}';
    String formatSeconds = seconds.length > 1 ? seconds : '0$seconds';
    return '$formatMins:$formatSeconds';
  }

  void playTimer() async {
    if (_duration.inSeconds == 0) return;
    showSimpleNotification(const Text("The timer has started"),
        background: Colors.green, position: NotificationPosition.bottom);
    timerController.start();
    timerController.resume();
    widget.onStart();
  }

  void pauseTimer() {
    if (_duration.inSeconds == 0) return;
    timerController.pause();
  }

  void resetTimer() {
    if (_duration.inSeconds == 0) return;
    timerController.restart();
    timerController.pause();
    // status
    context.read<CurrentStatus>().changeToNullStatus();
  }

  @override
  Widget build(BuildContext context) {
    Color? themePrimaryColor = Theme.of(context).textTheme.bodyLarge?.color;
    ScreenUtil().setSp(28);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: themePrimaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          const Gap(15),
          Countdown(
              controller: timerController,
              onFinished: () {
                //* onFinish
                widget.onFinish();
                timerController.restart();
                timerController.pause();
              },
              interval: const Duration(seconds: 1),
              seconds: _duration.inSeconds,
              build: (ctx, time) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Set the timer'),
                              content: SizedBox(
                                width: 300,
                                height: 100.h,
                                child: CupertinoTimerPicker(
                                  initialTimerDuration: _duration,
                                  onTimerDurationChanged: (value) {
                                    setState(() => _duration = value);
                                    CountTime.saveTimer(
                                        databaseName: widget.title,
                                        countTime: value.inSeconds);
                                  },
                                  mode: CupertinoTimerPickerMode.ms,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Set'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Dismiss the dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _duration = const Duration(seconds: 0);
                                    });
                                    CountTime.saveTimer(
                                        databaseName: widget.title,
                                        countTime: _duration.inSeconds);
                                    Navigator.of(context)
                                        .pop(); // Dismiss the dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Dismiss the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            Text(formatDuration(time),
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColorDark,
                                )),
                            //
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                          message: 'Play timer',
                          child: IconButton(
                              onPressed: () {
                                playTimer();
                              },
                              icon: Icon(
                                Icons.play_arrow_rounded,
                                size: 30.w,
                                color: Theme.of(context).primaryColorDark,
                              )),
                        ),
                        Tooltip(
                          message: 'Pause timer',
                          child: IconButton(
                              onPressed: () => pauseTimer(),
                              icon: Icon(
                                Icons.pause,
                                size: 30.w,
                                color: Theme.of(context).primaryColorDark,
                              )),
                        ),
                        Tooltip(
                          message: 'Reset timer',
                          child: IconButton(
                              onPressed: () => resetTimer(),
                              icon: Icon(
                                Icons.restart_alt_rounded,
                                size: 30.w,
                                color: Theme.of(context).primaryColorDark,
                              )),
                        ),
                      ],
                    )
                  ],
                );
              })
        ],
      ),
    );
  }
}
