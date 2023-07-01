
  import 'dart:typed_data';
import '/exports/exports.dart';

void sendNotification({required String title, required String body}) async {
     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      vibrationPattern: Int64List.fromList([100, 200, 300, 400, 500, 400, 300, 200, 400]),
      channelDescription: 'channel_description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      enableLights: true,
      
      color: Colors.blue,
      colorized: true,
      fullScreenIntent: true,
    );

     NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }