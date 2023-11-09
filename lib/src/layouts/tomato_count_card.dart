import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'tomato_list.dart';

class TomatoListCard extends StatelessWidget {
  const TomatoListCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tomato Count : ',
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorDark)),
        const Gap(10),
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
    );
  }
}
