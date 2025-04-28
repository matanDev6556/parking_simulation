import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    initialize();
  }

  Future<void> initialize() async {
    final initializationSettings = InitializationSettings(
      android: _androidSettings(),
      iOS: _iosSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  Future<void> scheduleNotification(DateTime scheduleTime) async {
    bool hasPermission = await checkAndRequestNotificationPermission();
    if (!hasPermission) {
      throw Exception('Notification permission not granted');
    }
    var notificationDetails = NotificationDetails(
      android: _androidNotificationDetails(),
      iOS: _iosNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Parking Reminder',
      'Your parking session is about to end',
      tz.TZDateTime.from(scheduleTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'scheduled',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    print('Notification clicked: ${response.payload}');
  }

  Future<bool> checkAndRequestNotificationPermission() async {
    return Platform.isIOS
        ? await _checkIOSNotificationPermission()
        : await _checkAndroidNotificationPermission();
  }

  Future<bool> _checkIOSNotificationPermission() async {
    final iosPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin != null) {
      bool? granted = await iosPlugin.requestPermissions(
          alert: true, badge: true, sound: true);
      print("iOS notification permission granted: $granted");
      return granted ?? false;
    }
    return false;
  }

  Future<bool> _checkAndroidNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied || status.isLimited) {
      status = await Permission.notification.request();
      print(status);
    }

    if (status.isGranted) {
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.canScheduleExactNotifications() ??
          false;
    }
    return false;
  }

  static AndroidInitializationSettings _androidSettings() {
    return const AndroidInitializationSettings('@mipmap/ic_launcher');
  }

  static AndroidNotificationDetails _androidNotificationDetails() {
    return const AndroidNotificationDetails(
      'parking_channel',
      'Parking Notifications',
      channelDescription: 'Notifications for parking status',
      importance: Importance.max,
      priority: Priority.high,
    );
  }

  static DarwinInitializationSettings _iosSettings() {
    return const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
    );
  }

  static DarwinNotificationDetails _iosNotificationDetails() {
    return const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
      interruptionLevel: InterruptionLevel.active,
    );
  }
}
