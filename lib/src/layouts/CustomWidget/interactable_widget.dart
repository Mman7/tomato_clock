import 'package:flutter/material.dart';

class InteractableWidget extends StatelessWidget {
  const InteractableWidget({
    Key? key,
    required this.canInteract,
    required this.child,
  }) : super(key: key);
  final bool canInteract;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: canInteract ? 1 : 0.5,
      child: Stack(
        children: [
          child,
          if (!canInteract)
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            )
        ],
      ),
    );
  }
}
