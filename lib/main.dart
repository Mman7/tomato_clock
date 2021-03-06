import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:tomato_clock/src/providers/tomato_database.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

//* Providers
import 'src/providers/tomato_providers.dart';
import 'src/providers/current_status_provider.dart';

//* Utils
import 'src/utils/background_app.dart';
import 'src/utils/notification.dart';

//* Layout
import 'src/layouts/History/history_page.dart';
import 'src/layouts/timer_controller.dart';
import 'src/layouts/custom_gradient_background.dart';
import 'src/layouts/theme.dart';
import 'src/layouts/tomato_count_card.dart';

import 'package:flutter_vibrate/flutter_vibrate.dart';

/// https://stackoverflow.com/a/66057043
///
// if build use:
// flutter build apk --split-per-abi --no-shrink --no-sound-null-safety
// or else it will not working

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundApp.intialBackgroundApp();

  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
  // runApp(MyApp());
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
        leading: Tooltip(
            message: 'History',
            child: IconButton(
                icon: const Icon(Icons.history),
                iconSize: ResponsiveFlutter.of(context).fontSize(2.75),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          reverseDuration: const Duration(milliseconds: 150),
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeInOut,
                          type: PageTransitionType.leftToRight,
                          child: const HistoryPage()));
                })),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: Tooltip(
                message: 'Refresh Tomato Count',
                child: IconButton(
                    iconSize: ResponsiveFlutter.of(context).fontSize(2.75),
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
        title: Text(
          'Tomato Clock',
          style:
              TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.75)),
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
            ],
          ),
        ),
      ),
    );
  }
}
