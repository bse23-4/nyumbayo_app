import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '/exports/exports.dart';
import 'package:timezone/timezone.dart' as tz;
void showMessage(
    {String type = 'info',
    String? msg,
    bool float = false,
    required BuildContext context,
    double opacity = 1,
    int duration = 5,
    Animation<double>? animation}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: float ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(msg ?? ''),
      backgroundColor: type == 'info'
          ? Colors.lightBlue
          : type == 'warning'
              ? Colors.orange[800]!.withOpacity(opacity)
              : type == 'danger'
                  ? Colors.red[800]!.withOpacity(opacity)
                  : type == 'success'
                      ? const Color.fromARGB(255, 2, 104, 7)
                          .withOpacity(opacity)
                      : Colors.grey[600]!.withOpacity(opacity),
      duration: Duration(seconds: duration),
    ),
  );
}

/// show progress widget
void showProgress(BuildContext context, {String? text = 'Task'}) {
  showCupertinoModalPopup(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    context: context,
    builder: (context) => BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.black12,
      onClosing: () {},
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitDualRing(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).primaryColor),
          const Space(
            space: 0.03,
          ),
          Text(
            "$text..",
            style: TextStyles(context)
                .getRegularStyle()
                .copyWith(color: Colors.white),
          )
        ],
      ),
    ),
  );
}


String formatNumberWithCommas(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

//  fucntion to schedule notifications
void scheduleNotificationReminders() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'reminder_channel_id',
    'Reminder Channel',
    importance: Importance.high,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Calculate the scheduled notification times
  final now = DateTime.now();
  final startTime = now.add(const Duration(minutes: 2));
  final endTime = now.add(const Duration(hours: 2));

  for (DateTime scheduledTime = startTime;
      scheduledTime.isBefore(endTime);
      scheduledTime = scheduledTime.add(const Duration(minutes: 2))) {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      scheduledTime.hashCode,
      'Reminder',
      'Notification reminder',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

 Future<void> requestPermissions() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      // setState(() {
      //   _notificationsEnabled = granted ?? false;
      // });
    }
  }