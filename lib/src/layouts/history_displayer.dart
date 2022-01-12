import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tomato_database.dart';
import 'custom_gradient_background.dart';
import 'history_tomato_card.dart';

class HistoryDisplayer extends StatefulWidget {
  const HistoryDisplayer({Key? key, required}) : super(key: key);

  @override
  State<HistoryDisplayer> createState() => _HistoryDisplayerState();
}

class _HistoryDisplayerState extends State<HistoryDisplayer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder<dynamic>(
        future: context.read<TomatoDataBase>().fetchData(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (snapshot.data == null) return Container();
                    var tomatoCount = snapshot.data?[index]['tomatoCount'];
                    var date = snapshot.data?[index]['date'];
                    var svgHeight = MediaQuery.of(context).size.height / 15;
                    return Column(
                      children: [
                        CustomGradientBackground(
                          firstColor: "#88FFA7",
                          secondColor: '#3A754A',
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TomatoCard(
                                date: date,
                                svgHeight: svgHeight,
                                tomatoCount: tomatoCount),
                          ),
                        ),
                        const Divider(
                          height: 30,
                          thickness: 2,
                        )
                      ],
                    );
                  }),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ));
  }
}
