import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TomatoCard extends StatefulWidget {
  const TomatoCard({
    Key? key,
    required this.date,
    required this.tomatoCount,
  }) : super(key: key);

  final String date;
  final int tomatoCount;

  @override
  State<TomatoCard> createState() => _TomatoCardState();
}

class _TomatoCardState extends State<TomatoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ]),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        title: Text(
          widget.date.toString(),
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
                width: MediaQuery.of(context).size.height / 15,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'x ${widget.tomatoCount}',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
