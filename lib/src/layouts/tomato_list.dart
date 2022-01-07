import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class TomatoList extends StatelessWidget {
  TomatoList({Key? key, this.tomatoCount}) : super(key: key);
  int? tomatoCount;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 10;
    return Container(
      decoration: BoxDecoration(
          color: HexColor('#E5FFEC'),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(15.0),
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < (tomatoCount ?? 0); i++)
            SvgPicture.asset(
              'assert/tomato.svg',
              width: height,
            ),
        ],
      ),
    );
  }
}
