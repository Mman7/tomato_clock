import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

showCustomDialog(
    {required BuildContext context,
    required String title,
    required String msg,
    onPress}) {
  return showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: ElasticInUp(
        duration: const Duration(milliseconds: 400),
        child: AlertDialog(title: Text(title), content: Text(msg), actions: [
          IconButton(
            onPressed: () =>
                onPress == null ? Navigator.of(context).pop() : onPress(),
            icon: const Icon(Icons.check),
            color: Colors.blue,
            iconSize: 30,
          )
        ]),
      ),
    ),
  );
}

specialCustomDialog(
    {required BuildContext context,
    required String title,
    required String msg}) {
  return showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: ElasticInUp(
        duration: const Duration(milliseconds: 400),
        child: AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Theme.of(context).primaryColor,
            title: Wrap(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(Icons.emoji_food_beverage_outlined,
                    color: Colors.white)
              ],
            ),
            content: Text(msg, style: const TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.check),
                color: Colors.white,
                iconSize: 30,
              )
            ]),
      ),
    ),
  );
}
