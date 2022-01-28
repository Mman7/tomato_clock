import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';
import 'package:tomato_clock/src/tomato_database.dart';

import '../notification.dart';
import 'interactable_widget.dart';
import 'timer_control_card.dart';
import '../show_dialog.dart';

class TimerController extends StatelessWidget {
  const TimerController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _status = context.watch<CurrentStatus>().status;
    final width = MediaQuery.of(context).size.width;
    double statusChecker(value) {
      if (_status == null) return 1;
      return _status == value ? 1 : 0.5;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InteractableWidget(
              canInteract: statusChecker('focus') != 1,
              child: Opacity(
                opacity: statusChecker('focus'),
                child: TimerControlCard(
                  title: 'Focus',
                  countMinute: 15,
                  onStart: () => context
                      .read<CurrentStatus>()
                      .changeStatus(value: 'focus'),
                  onFinish: () {
                    context.read<TomatoCount>().increaseTomatoCount();
                    context.read<TomatoDataBase>().increaseTomatoData();
                    context.read<CurrentStatus>().changeStatus(value: 'rest');
                    context.read<NotificationService>().instantNotification();
                    TomatoCount provider = context.read<TomatoCount>();
                    int tomatoCount = provider.tomatoCount;

                    if (tomatoCount == 4) {
                      specialCustomDialog(
                          context: context,
                          title: 'Time to Long Rest  ',
                          msg: 'You can now Rest a little bit longer');
                      provider.cleanTomatoCount();
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
          ),
          SizedBox(
            width: width / 15,
          ),
          Expanded(
            child: InteractableWidget(
              canInteract: statusChecker('rest') != 1,
              child: Opacity(
                opacity: statusChecker('rest'),
                child: TimerControlCard(
                  title: 'Rest',
                  countMinute: 5,
                  onStart: () =>
                      context.read<CurrentStatus>().changeStatus(value: 'rest'),
                  onFinish: () {
                    context.read<CurrentStatus>().changeStatus(value: 'focus');
                    context.read<NotificationService>().instantNotification();
                    showCustomDialog(
                        context: context,
                        title: 'Time to Focus !',
                        msg:
                            "It's time to focus, press the start button to start counting");
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
