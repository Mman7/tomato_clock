import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';

class TomatoList extends StatelessWidget {
  const TomatoList({Key? key}) : super(key: key);

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
          for (var i = 0; i < (context.watch<TomatoCount>().tomatoCount); i++)
            SvgPicture.asset(
              'assert/tomato.svg',
              width: height,
            ),
        ],
      ),
    );
  }
}
