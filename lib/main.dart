import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/tomato_database.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';
// Providers

import 'src/layouts/bottom_history_bar.dart';
import 'src/notification.dart';
import 'src/providers/current_status_provider.dart';

import 'src/layouts/timer_controller.dart';
import 'src/providers/tomato_providers.dart';
import 'src/layouts/custom_gradient_background.dart';
import 'src/layouts/theme.dart';
import 'src/layouts/tomato_count_card.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (task == 'simpleTask') {
      print('exec simpleTask');
    }
    return Future.value(true);
  });
}

void main() async {
  /// https://stackoverflow.com/a/66057043
  ///
  // if build use:
  // flutter build apk --split-per-abi --no-shrink
  // or else it will not working
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager()
      .registerPeriodicTask('1', 'simpeTask', frequency: Duration(minutes: 15));
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}

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
        ),
        ChangeNotifierProvider(create: (_) => TomatoDataBase())
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Tomato Clock',
          theme: theme(context),
          home: const MyHomePage(),
        ),
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
    final tomatoCount = context.read<TomatoCount>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: Tooltip(
                message: 'Refresh Tomato Count',
                child: IconButton(
                    onPressed: () => tomatoCount.cleanTomatoCount(),
                    icon: const Icon(Icons.refresh))),
          )
        ],
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
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

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
