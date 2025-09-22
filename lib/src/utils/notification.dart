import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //initilize
  static Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Instant Notifications
  static Future instantNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'id',
      'tomato',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'ic_stat_access_alarm', // ✅ must match the resource name
    );
    var ios = const DarwinNotificationDetails();

    var platform =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: ios);
    await _flutterLocalNotificationsPlugin.show(
        0, "Time's up Buddy !", 'Tap here recount your time', platform,
        payload: 'Welcome to demo app');
  }
}
