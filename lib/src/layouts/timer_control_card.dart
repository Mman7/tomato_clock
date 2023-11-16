import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:tomato_clock/src/layouts/CustomWidget/custom_material.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Database/count_time_database.dart';

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

class _TimerControlCardState extends State<TimerControlCard>
    with AfterLayoutMixin<TimerControlCard> {
  var seconds = 0;
  var isButtonDisable = false;
  final timerController = CountdownController();

  @override
  void initState() {
    CountTime.getTimer(databaseName: widget.title)
        .then((value) => setState(() => seconds = value));
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    timerController.setOnStart(() {
      setState(() => isButtonDisable = true);
    });
  }

  void addSeconds() {
    setState(() => seconds += 300);
    CountTime.saveTimer(databaseName: widget.title, countTime: seconds);
  }

  void reduceSeconds() {
    setState(() => seconds -= 300);
    CountTime.saveTimer(databaseName: widget.title, countTime: seconds);
  }

  minuteToSeconds(value) => Duration(minutes: value).inSeconds;
  secondsToMinute(value) => Duration(seconds: value).inMinutes;

  @override
  Widget build(BuildContext context) {
    Color? themePrimaryColor = Theme.of(context).textTheme.bodyLarge?.color;
    ScreenUtil().setSp(28);
    //*  Minumum minute
    if (seconds < minuteToSeconds(5)) seconds = minuteToSeconds(5);

    //* Maximum minute
    if (seconds > minuteToSeconds(60)) seconds = minuteToSeconds(60);

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
        mainAxisAlignment: MainAxisAlignment.center,
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
                setState(() => isButtonDisable = false);
              },
              interval: const Duration(seconds: 1),
              seconds: seconds,
              build: (ctx, time) {
                var timerToText = '${secondsToMinute(time.toInt())} mins';

                return Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customMaterial(
                            child: Tooltip(
                              message: 'Add 5 minute',
                              child: IconButton(
                                  onPressed: () =>
                                      isButtonDisable ? null : addSeconds(),
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColorDark,
                                    size: 30.r,
                                  )),
                            ),
                          ),
                          //
                          Text(time <= 60 ? '${time.toInt()} sec' : timerToText,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: seconds > 300 ? 15.5.sp : 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark,
                              )),
                          //
                          customMaterial(
                            child: Tooltip(
                              message: 'reduce 5 minute',
                              child: IconButton(
                                  onPressed: () =>
                                      isButtonDisable ? null : reduceSeconds(),
                                  icon: Icon(
                                    Icons.remove_circle,
                                    size: 30.w,
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                            ),
                          )
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customMaterial(
                          child: Tooltip(
                            message: 'Play timer',
                            child: IconButton(
                                onPressed: () {
                                  isButtonDisable
                                      ? null
                                      : {
                                          showSimpleNotification(
                                              const Text(
                                                  "The timer has started"),
                                              background: Colors.green,
                                              position:
                                                  NotificationPosition.bottom),
                                          timerController.start(),
                                          timerController.resume(),
                                          widget.onStart()
                                        };
                                },
                                icon: Icon(
                                  Icons.play_arrow_rounded,
                                  size: 30.w,
                                  color: Theme.of(context).primaryColorDark,
                                )),
                          ),
                        ),
                        customMaterial(
                          child: Tooltip(
                            message: 'Pause timer',
                            child: IconButton(
                                onPressed: () => timerController.pause(),
                                icon: Icon(
                                  Icons.pause,
                                  size: 30.w,
                                  color: Theme.of(context).primaryColorDark,
                                )),
                          ),
                        ),
                        customMaterial(
                          child: Tooltip(
                            message: 'Reset timer',
                            child: IconButton(
                                onPressed: () {
                                  timerController.restart();
                                  timerController.pause();
                                  setState(() => isButtonDisable = false);

                                  // status
                                  final status = context.read<CurrentStatus>();
                                  status.changeToNullStatus();
                                },
                                icon: Icon(
                                  Icons.restart_alt_rounded,
                                  size: 30.w,
                                  color: Theme.of(context).primaryColorDark,
                                )),
                          ),
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
