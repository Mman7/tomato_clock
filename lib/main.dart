import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'src/layouts/custom_gradient_background.dart';
import 'src/layouts/theme.dart';
import 'src/layouts/timer_control_card.dart';
import 'src/layouts/tomato_count_card.dart';

void main() {
  runApp(const MyApp());
}

//TODO find how to make a functional clock

// TODO find a way make bottom sheet and make sure it functional

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomato Clock',
      theme: themeData,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height * 2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        title: const Text(
          'Tomato Clock',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: CustomGradientBackground(
        /// this will take all the space
        width: MediaQuery.of(context).size.width,
        firstColor: '#88FFA7',
        secondColor: '#3A754A',
        child: Padding(
          padding: EdgeInsets.only(top: appBarHeight),
          child: Column(
            children: [
              TomatoListCard(
                tomatoCount: 0,
              ),
              const SizedBox(
                height: 35,
              ),
              // Timer Controller
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    TimerControlCard(
                      title: 'Focus',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TimerControlCard(
                      title: 'Rest',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
