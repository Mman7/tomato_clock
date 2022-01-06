import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class CustomGradientBackground extends StatelessWidget {
  CustomGradientBackground(
      {Key? key,
      required this.child,
      this.firstColor,
      this.secondColor,
      this.boxShadow,
      this.borderRadius,
      this.height,
      this.width})
      : super(key: key);

  BorderRadius? borderRadius;
  List<BoxShadow>? boxShadow;
  final Widget? child;
  String? firstColor;
  String? secondColor;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: borderRadius,
        gradient: LinearGradient(
            colors: [
              HexColor(firstColor ?? '#00000'),
              HexColor(secondColor ?? '#fffff'),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: child,
    );
  }
}
