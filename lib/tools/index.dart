import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '/exports/exports.dart';
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
      content: Text(msg ?? '',style: TextStyle(fontSize: 17),),
      backgroundColor: type == 'info'
          ? Colors.lightBlue
          : type == 'warning'
              ? Colors.orange[400]!.withOpacity(opacity)
              : type == 'danger'
                  ? Colors.red[400]!.withOpacity(opacity)
                  : type == 'success'
                      ? const Color.fromARGB(255, 2, 104, 7)
                          .withOpacity(opacity)
                      : Colors.grey[500]!.withOpacity(opacity),
      duration: Duration(seconds: duration),
    ),
  );
}
/// alert dialog
showAlertMsg(BuildContext context,{String content = "", String title = ""}) {
  showDialog(context: context, builder: (context){
    return  AlertDialog(
      title: Text(title,style: TextStyles(context).getRegularStyle(),),
      content: Text(content,style: TextStyles(context).getRegularStyle(),),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("OK",style: TextStyles(context).getRegularStyle(),),
        )
      ],
    );
  });
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

 Future<void> requestPermissions() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

       await androidImplementation?.requestPermission();
      // setState(() {
      //   _notificationsEnabled = granted ?? false;
      // });
    }
  }

  // function to detect the start of a new month
bool isStartOfMonth(DateTime date) {
  return date.day == 1;
}
// function to handle date
String formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}
// fuction to handle time
String formatTime(DateTime date) {
  return DateFormat('hh:mm a').format(date);
}
// function to handle date
String formatDateTime(DateTime date) {
  return DateFormat('dd-MM-yyyy hh:mm a').format(date);
}
// function to handle image upload in form of base64
Future<File> uploadImage() async {
   final ImagePicker _picker = ImagePicker();
  var file = await _picker.pickImage(source: ImageSource.camera);
  return (File(file!.path));
}
// function to handle image upload in form of base64
Future<File> captureImage() async {
   final ImagePicker _picker = ImagePicker();
  var file = await _picker.pickImage(source: ImageSource.gallery);
  return (File(file!.path));
}

