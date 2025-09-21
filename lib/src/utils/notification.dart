// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService extends ChangeNotifier {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   //initilize
//   Future initialize() async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // Instant Notifications
//   Future instantNotification() async {
//     var android = const AndroidNotificationDetails('id', 'channel');

//     var ios = const DarwinNotificationDetails();

//     var platform = NotificationDetails(android: android, iOS: ios);

//     await _flutterLocalNotificationsPlugin.show(
//         0, "Time's up Buddy !", 'Tap here recount your time', platform,
//         payload: 'Welcome to demo app');
//   }
// }
