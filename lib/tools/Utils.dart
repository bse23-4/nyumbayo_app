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
  showModal(
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
//  date format
String formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}