import 'dart:ui';

import 'package:intl/intl.dart';

import '/exports/exports.dart';

void showOptions(BuildContext context) {
  showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.7),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: BottomSheet(
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed(Routes.addTenant);
                            },
                            leading: const CircleAvatar(
                              child: Icon(Icons.person_add_alt_1_outlined,
                                  color: Colors.white),
                            ),
                            title: Text(
                              "Add new tenant",
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.view_list_outlined,
                                  color: Colors.white),
                            ),
                            title: Text(
                              "View Reports",
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      });
}

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
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        child: SizedBox(
          height: 90,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: SpinKitDualRing(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              ),
              const SizedBox(
                width: 50,
              ),
              Text(
                "$text..",
                style: TextStyles(context).getRegularStyle(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

String formatNumberWithCommas(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

//  date format
String formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String formatTime(DateTime date) {
  return DateFormat('hh:mm a').format(date);
}

void showAlertWindow(BuildContext context,
    {String title = "", String content = ""}) {
  showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.width / 3,
          child: AlertDialog(
            title: const Center(
              child: Text("Are you sur you want to resolve this issue?"),
            ),
            actions: [
              TextButton(
                child: const Text("Approve"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Reject this issue",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}


String separateZerosWithCommas(String zeros) {
  final formatter = NumberFormat("#,###");
  int value = int.parse(zeros);
  return formatter.format(value);
}