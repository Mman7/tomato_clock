//* Package
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:tomato_clock/src/layouts/CustomWidget/custom_gradient_background.dart';
import 'package:tomato_clock/src/layouts/Tomato_Icon_List/tomato_count_card.dart';
import 'package:tomato_clock/src/layouts/timer_controller.dart';
import 'package:tomato_clock/src/utils/show_dialog.dart';

//* Providers
import 'src/providers/tomato_providers.dart';
import 'src/providers/current_status_provider.dart';

//* Utils
import 'src/utils/background_app.dart';
import 'src/utils/notification.dart';

//* Layout
import 'src/layouts/HistoryView/history_page.dart';
import 'src/layouts/Theme/theme.dart';

/// https://stackoverflow.com/a/6605704
///
// if build use:
// flutter build apk --split-per-abi --no-shrink

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundApp.intialBackgroundApp();

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
        ChangeNotifierProvider(
          create: (_) => NotificationService(),
        ),
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool isHistoryBasOpen = false;
  historyBarValue() => isHistoryBasOpen
      ? MediaQuery.of(context).size.height / 20
      : MediaQuery.of(context).size.height / 1.25;

  checkBatteryOptimize() {
    OptimizeBattery.isIgnoringBatteryOptimizations().then((onValue) {
      setState(() {
        if (onValue) {
          // Igonring Battery Optimization
        } else {
          // App is under battery optimization
          showCustomDialog(
              context: context,
              onPress: () {
                OptimizeBattery.openBatteryOptimizationSettings();
              },
              title: 'Turn off battery optimization',
              msg: 'For App working properly please turn battery optimization');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkBatteryOptimize();
    context.read<NotificationService>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    checkBatteryOptimize();
    final appBarHeight = AppBar().preferredSize.height * 2;
    final tomatoCount = context.read<TomatoCount>();
    return ScreenUtilInit(
      designSize: Size(360, 690),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Tooltip(
              message: 'History',
              child: IconButton(
                  icon: const Icon(Icons.history),
                  iconSize: 25,
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
                  message: 'Refresh Tomato Count',
                  child: IconButton(
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
      ),
    );
  }
}
