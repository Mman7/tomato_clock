import 'package:flutter_background/flutter_background.dart';

class BackgroundApp {
  static intialBackgroundApp() async {
    const androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "flutter_background example app",
      notificationText:
          "Background notification for keeping the example app running in the background",
      notificationImportance: AndroidNotificationImportance.Default,
      enableWifiLock: true,
      notificationIcon: AndroidResource(
          name: 'background_icon',
          defType:
              '@mipmap/ic_launcher'), // Default is ic_launcher from folder mipmap
    );

    await FlutterBackground.initialize(androidConfig: androidConfig);
  }

  static runBackgroundApp() async {
    // print('activated background');
    await FlutterBackground.enableBackgroundExecution();
  }

  static stopBackgroundApp() async {
    // print('deactivated background');
    await FlutterBackground.disableBackgroundExecution();
  }
}
