import 'package:flutter/material.dart';
import 'tomato_list.dart';

class TomatoListCard extends StatelessWidget {
  TomatoListCard({Key? key, this.tomatoCount}) : super(key: key);
  int? tomatoCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tomato Count : ',
              style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark)),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 5),
                    spreadRadius: 1,
                    blurRadius: 4)
              ],
            ),
            child: TomatoList(
              tomatoCount: tomatoCount,
            ),
          ),
        ],
      ),
    );
  }
}
