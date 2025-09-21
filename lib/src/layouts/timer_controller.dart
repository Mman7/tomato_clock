import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';
import 'package:tomato_clock/src/Database/tomato_database.dart';
import 'package:tomato_clock/src/utils/background_app.dart';

import '../utils/notification.dart';
import 'CustomWidget/interactable_widget.dart';
import 'timer_control_card.dart';
import '../utils/show_dialog.dart';

class TimerController extends StatefulWidget {
  const TimerController({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerController> createState() => _TimerControllerState();
}

class _TimerControllerState extends State<TimerController> {
  @override
  Widget build(BuildContext context) {
    var currentState = context.read<CurrentStatus>();
    var _tomatoCount = context.watch<TomatoCount>();
    CurrentTimer? currentStatus = context.watch<CurrentStatus>().status;

    return Row(
      children: [
        Expanded(
          child: InteractableWidget(
            canInteract: currentStatus == CurrentTimer.none ||
                currentStatus == CurrentTimer.focus,
            child: TimerControlCard(
              title: 'Focus',
              onStart: () {
                BackgroundApp.intialBackgroundApp();
                BackgroundApp.runBackgroundApp();
                currentState.changeStatus(value: CurrentTimer.focus);
              },
              onFinish: () {
                currentState.changeStatus(value: CurrentTimer.rest);
                _tomatoCount.increaseTomatoCount();
                TomatoDataBase.addNewTomatoData();
                // context.read<NotificationService>().instantNotification();
                BackgroundApp.stopBackgroundApp();

                if (_tomatoCount.tomatoCount == 4) {
                  _tomatoCount.cleanTomatoCount();
                  specialCustomDialog(
                      context: context,
                      title: 'Time to Long Rest  ',
                      msg: 'You can now Rest a little bit longer');
                } else {
                  showCustomDialog(
                      context: context,
                      title: 'Time to Rest !',
                      msg:
                          'You can now rest, press the start button to start counting');
                }
              },
            ),
          ),
        ),
        const Gap(15),
        Expanded(
          child: InteractableWidget(
            canInteract: currentStatus == CurrentTimer.none ||
                currentStatus == CurrentTimer.rest,
            child: TimerControlCard(
              title: 'Rest',
              onStart: () {
                currentState.changeStatus(value: CurrentTimer.rest);
              },
              onFinish: () {
                currentState.changeStatus(value: CurrentTimer.focus);
                // context.read<NotificationService>().instantNotification();
                showCustomDialog(
                    context: context,
                    title: 'Time to Focus !',
                    msg:
                        "It's time to focus, press the start button to start counting");
              },
            ),
          ),
        ),
      ],
    );
  }
}
