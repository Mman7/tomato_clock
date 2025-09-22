//* Package

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/layouts/CustomWidget/custom_gradient_background.dart';
import 'package:tomato_clock/src/layouts/Tomato_Icon_List/tomato_count_card.dart';
import 'package:tomato_clock/src/layouts/timer_controller.dart';

//* Providers
import 'src/providers/tomato_providers.dart';
import 'src/providers/current_status_provider.dart';

//* Utils
import 'src/utils/notification.dart';

//* Layout
import 'src/layouts/HistoryView/history_page.dart';
import 'src/layouts/Theme/theme.dart';

// if build use:
// flutter build apk --split-per-abi --no-shrink
final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  // init timezone
  WidgetsFlutterBinding.ensureInitialized();

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const settings = InitializationSettings(android: android);

  await notificationsPlugin.initialize(settings);

  // Ask permission for Android 13+
  final androidImpl = notificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await androidImpl?.requestExactAlarmsPermission();
  await androidImpl?.requestNotificationsPermission();
  await androidImpl?.requestExactAlarmsPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TomatoCount()),
        ChangeNotifierProvider(create: (_) => CurrentStatus()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height * 2;
    final tomatoCount = context.read<TomatoCount>();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Tooltip(
              message: 'History',
              child: IconButton(
                  icon: const Icon(Icons.date_range_rounded),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Widget bottomSheet(
                      BuildContext context,
                      ScrollController scrollController,
                      double bottomSheetOffset,
                    ) {
                      return HistoryPage(
                        scrollController: scrollController,
                      );
                    }

                    showFlexibleBottomSheet(
                      bottomSheetBorderRadius:
                          const BorderRadius.all(Radius.circular(15)),
                      minHeight: 0,
                      initHeight: 0.5,
                      maxHeight: 1,
                      isModal: true,
                      context: context,
                      builder: bottomSheet,
                      anchors: [0, 0.5, 1],
                      isSafeArea: true,
                    );
                  })),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Tooltip(
                  message: 'Reset Tomato',
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        context.read<CurrentStatus>().changeToNullStatus();
                        tomatoCount.cleanTomatoCount();
                      },
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
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ),
        body: CustomGradientBackground(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          firstColor: '#88FFA7',
          secondColor: '#3A754A',
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight, left: 20, right: 20),
            child: const Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TomatoListCard(),
                    Gap(30),
                    TimerController(),
                  ],
                ),
              ],
            ),
          ),
        ),
        // body: Container(),
      ),
    );
  }
}
