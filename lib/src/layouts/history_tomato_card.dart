import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TomatoCard extends StatefulWidget {
  TomatoCard({
    Key? key,
    required this.date,
    required this.svgHeight,
    required this.tomatoCount,
  }) : super(key: key);

  var date;
  final double svgHeight;
  var tomatoCount;

  @override
  State<TomatoCard> createState() => _TomatoCardState();
}

class _TomatoCardState extends State<TomatoCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${widget.date}',
        style: TextStyle(
            color: Theme.of(context).primaryColorDark.withAlpha(255),
            fontWeight: FontWeight.w700),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/tomato.svg',
              width: widget.svgHeight,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'x ${widget.tomatoCount}',
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
