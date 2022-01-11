import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'src/layouts/bottom_history_bar.dart';
import 'src/notification.dart';
import 'src/providers/current_status_provider.dart';

import 'src/layouts/timer_controller.dart';
import 'src/providers/tomato_providers.dart';
import 'src/layouts/custom_gradient_background.dart';
import 'src/layouts/theme.dart';
import 'src/layouts/tomato_count_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// save todo with localstore 1.2.1

// TODO find a way make bottom sheet and make sure it functional

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TomatoCount()),
        ChangeNotifierProvider(create: (_) => CurrentStatus()),
        ChangeNotifierProvider(
          create: (_) => NotificationService(),
        )
      ],
      child: MaterialApp(
        title: 'Tomato Clock',
        theme: theme(context),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHistoryBasOpen = false;
  historyBarValue() => isHistoryBasOpen
      ? MediaQuery.of(context).size.height / 20
      : MediaQuery.of(context).size.height / 1.25;

  @override
  void initState() {
    super.initState();
    context.read<NotificationService>().initialize();
  }

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
          padding: EdgeInsets.only(
            top: appBarHeight,
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  TomatoListCard(),
                  SizedBox(
                    height: 35,
                  ),
                  TimerController(),
                ],
              ),
              const BottomHistoryBar()
            ],
          ),
        ),
      ),
    );
  }
}
