import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleDailyNotification(
      {int hour = 22, int minute = 0}) async {
    if (await checkExactAlarmPermission()) {
      tz.initializeTimeZones();
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      final tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Keep in mind!',
        'Don\'t forget to track your expenses today!',
        scheduledDate.isBefore(now)
            ? scheduledDate.add(const Duration(days: 1))
            : scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_notification_channel_id',
            'Daily Notification',
            channelDescription: 'Daily notification at your selected time',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      requestExactAlarmPermission();
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<bool> checkExactAlarmPermission() async {
    return await Permission.scheduleExactAlarm.isGranted;
  }

  Future<void> requestExactAlarmPermission() async {
    PermissionStatus status = await Permission.scheduleExactAlarm.request();
    if (status != PermissionStatus.granted) {
      log("Exact alarm permission not granted.");
    }
    PermissionStatus notificationStatus =
        await Permission.notification.request();
    if (notificationStatus != PermissionStatus.granted) {
      log("Notification permission not granted.");
    }
  }
}
