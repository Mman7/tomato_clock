import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
      primaryColorDark: HexColor('#125E2B'),
      primaryColor: HexColor('#4BAF66'),
      dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor),
          contentTextStyle: TextStyle(
              fontSize: 17,
              color: Theme.of(context).textTheme.bodyLarge?.color),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      textTheme: TextTheme(bodyLarge: TextStyle(color: HexColor('#0D4721'))));
}
