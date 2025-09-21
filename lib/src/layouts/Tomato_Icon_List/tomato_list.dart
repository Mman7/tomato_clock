import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/providers/tomato_providers.dart';

class TomatoList extends StatefulWidget {
  const TomatoList({Key? key}) : super(key: key);

  @override
  State<TomatoList> createState() => _TomatoListState();
}

class _TomatoListState extends State<TomatoList> {
  @override
  void initState() {
    context.read<TomatoCount>().intialCurrentTomato();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 8;
    final tomatoCount = context.watch<TomatoCount>().tomatoCount;

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < tomatoCount; i++)
            SvgPicture.asset(
              'assets/tomato.svg',
              width: height,
            ),

          // when count is 0 need to something to fill the space
          if (tomatoCount == 0)
            Opacity(
              opacity: 0,
              child: SvgPicture.asset(
                'assets/tomato.svg',
                width: height,
              ),
            ),
        ],
      ),
    );
  }
}
