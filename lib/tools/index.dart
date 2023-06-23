// ignore_for_file: use_build_context_synchronously

import '/exports/exports.dart';

showAlertMsg(BuildContext context, {String title = "", String content = ""}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, style: TextStyles(context).getRegularStyle()),
      content: Text(content, style: TextStyles(context).getRegularStyle()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Okay"),
        ),
      ],
    ),
  );
}

// function to resolve the complain

// resolve complaint
void resolveComplaint(String option, List<TextEditingController> controllers,
    FutureOr<void> Function()? onDurationEnd) {
  if (option == "hours") {
    // resolve complaint after hours
    final int hours = int.parse(controllers[0].text);
    final int seconds = hours * 3600;
    final int milliseconds = seconds * 1000;
    // resolve complaint after milliseconds
    Future.delayed(Duration(milliseconds: milliseconds), () {
      // resolve complaint
      onDurationEnd!();
      print("Complaint resolved after $hours hours");
    });
  } else if (option == "minutes") {
    // resolve complaint after minutes
    final int minutes = int.parse(controllers[1].text);
    final int seconds = minutes * 60;
    final int milliseconds = seconds * 1000;
    // resolve complaint after milliseconds
    Future.delayed(Duration(milliseconds: milliseconds), () {
      // resolve complaint
      onDurationEnd!();

      print("Complaint resolved after $minutes minutes");
    });
  } else if (option == "days") {
    // resolve complaint after days
    final int days = int.parse(controllers[2].text);
    final int hours = days * 24;
    final int seconds = hours * 3600;
    final int milliseconds = seconds * 1000;
    // resolve complaint after milliseconds
    Future.delayed(Duration(milliseconds: milliseconds), () {
      // resolve complaint
      onDurationEnd!();
      print("Complaint resolved after $days days");
    });
  } else if (option == "weeks") {
    // resolve complaint after weeks
    final int weeks = int.parse(controllers[3].text);
    final int days = weeks * 7;
    final int hours = days * 24;
    final int seconds = hours * 3600;
    final int milliseconds = seconds * 1000;
    // resolve complaint after milliseconds
    Future.delayed(Duration(milliseconds: milliseconds), () {
      // resolve complaint
      onDurationEnd!();
      print("Complaint resolved after $weeks weeks");
    });
  }
}

// function to turn on or off power from tenant.
void handleIssue(
    String id, String powerStatus, String complaintStatus, String msg) async {
  await FirebaseFirestore.instance
      .collection("tenants")
      .doc(id)
      .update({'power_status': powerStatus});
  // resolve complaint.
  await FirebaseFirestore.instance
      .collection("complaints")
      .doc(id)
      .update({'status': complaintStatus, 'reason': msg});
}

// initializing local notifications
void initializeNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('android12splash');
  // iOS settings
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  // initialization settings for both Android and iOS
  InitializationSettings initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
// request ios permission
flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
    );
    // request android permission
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    if (kDebugMode) {
      print(payload);
    }
  });
}

// function to push a notification incase a new complaint is submitted
void sendNotification(
    {required String title,
    required int notification_id,
    required String body}) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    // styleInformation: BigPictureStyleInformation(
    //   const DrawableResourceAndroidBitmap('android12splash'),
    //   largeIcon: const DrawableResourceAndroidBitmap('android12splash'),
    //   contentTitle: title,
    //   summaryText: body,
    //   htmlFormatContentTitle: true,
    //   htmlFormatSummaryText: true,),
    priority: Priority.high,
    enableLights: true,
    colorized: true,
    fullScreenIntent: true,
  );

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );
// render the notification
  await flutterLocalNotificationsPlugin.show(
    notification_id,
    title,
    body,
    platformChannelSpecifics,
  );
}
