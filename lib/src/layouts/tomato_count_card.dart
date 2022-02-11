import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';
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
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.75),
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark)),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: const TomatoList(),
          ),
        ],
      ),
    );
  }
}
