import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'tomato_list.dart';

class TomatoListCard extends StatelessWidget {
  const TomatoListCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tomato Count : ',
              style: TextStyle(
                  fontSize: 2.75.h,
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
                    spreadRadius: 2,
                    blurRadius: 5)
              ],
            ),
            child: const TomatoList(),
          ),
        ],
      ),
    );
  }
}
