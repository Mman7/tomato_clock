import 'package:flutter/material.dart';

class InteractableWidget extends StatelessWidget {
  const InteractableWidget({Key? key, required this.canInteract, this.child})
      : super(key: key);
  final bool canInteract;
  // ignore: prefer_typing_uninitialized_variables
  final child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (canInteract)
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
            ),
          )
      ],
    );
  }
}
