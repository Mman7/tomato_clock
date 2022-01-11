import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/providers/current_status_provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';

import 'timer_control_card.dart';

class TimerController extends StatelessWidget {
  const TimerController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _status = context.watch<CurrentStatus>().status;
    double statusChecker(value) {
      if (_status == null) return 1;
      return _status == value ? 1 : 0.5;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Stack(
            children: [
              Opacity(
                opacity: statusChecker('focus'),
                child: TimerControlCard(
                  title: 'Focus',
                  countMinute: 25,
                  onStart: () => context
                      .read<CurrentStatus>()
                      .changeStatus(value: 'focus'),
                  onFinish: () {
                    context.read<TomatoCount>().increaseTomatoCount();
                    context.read<CurrentStatus>().changeStatus(value: 'rest');
                  },
                ),
              ),
              if (statusChecker('focus') != 1.0)
                Positioned.fill(
                    child: Container(
                  color: Colors.transparent,
                ))
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Stack(
            children: [
              Opacity(
                opacity: statusChecker('rest'),
                child: TimerControlCard(
                  title: 'Rest',
                  countMinute: 5,
                  onStart: () =>
                      context.read<CurrentStatus>().changeStatus(value: 'rest'),
                  onFinish: () {
                    context.read<CurrentStatus>().changeStatus(value: 'focus');
                  },
                ),
              ),
              if (statusChecker('focus') == 1.0)
                Positioned.fill(
                  child: Container(
                    color: Colors.transparent,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
