import 'package:flutter/material.dart';
import 'src/layouts/custom_gradient_background.dart';
import 'src/layouts/theme.dart';

void main() {
  runApp(const MyApp());
}

//TODO find how to make a functional clock

//TODO find a way add a tomato svg

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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tomato Count : ',
                    style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColorDark)),
                CustomGradientBackground(
                  firstColor: '#48D356',
                  secondColor: '#9EFFA8',
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 5),
                        spreadRadius: 1,
                        blurRadius: 4)
                  ],
                  width: 300,
                  height: 100,
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('tomato'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
