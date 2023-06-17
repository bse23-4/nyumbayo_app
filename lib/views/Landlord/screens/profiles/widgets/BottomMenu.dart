import '/exports/exports.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

String option = "";
// text controllers
final TextEditingController _hoursController = TextEditingController();
final TextEditingController _minutesController = TextEditingController();
final TextEditingController _daysController = TextEditingController();
final TextEditingController _weeksController = TextEditingController();

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text("Set the duration for which the resolution should last.",
              style: TextStyles(context).getBoldStyle()),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Select the duration",
            style: TextStyles(context).getRegularStyle(),
          ),
        ),
        RadioMenuButton(
          value: "hours",
          groupValue: option,
          onChanged: (x) {
            setState(() {
              option = x ?? "";
            });
          },
          child: Text(
            "Hours",
            style: TextStyles(context).getRegularStyle(),
          ),
        ),
        if (option == "hours")
          CommonTextField(
            icon: Icons.timer,
            controller: _hoursController,
            hintText: "Provide the number of hours",
            keyboardType: TextInputType.number,
            padding: const EdgeInsets.only(left: 15, right: 15),
          ),
        // minutes
        RadioMenuButton(
          value: "minutes",
          groupValue: option,
          onChanged: (x) {
            setState(() {
              option = x ?? "";
            });
          },
          child: Text(
            "Minutes",
            style: TextStyles(context).getRegularStyle(),
          ),
        ),
        if (option == "minutes")
          CommonTextField(
            icon: Icons.timer,
            controller: _minutesController,
            hintText: "Provide the number of minutes",
            keyboardType: TextInputType.number,
            padding: const EdgeInsets.only(left: 15, right: 15),
          ),
        //  days
        RadioMenuButton(
          value: "days",
          groupValue: option,
          onChanged: (x) {
            setState(() {
              option = x ?? "";
            });
          },
          child: Text(
            "Days",
            style: TextStyles(context).getRegularStyle(),
          ),
        ),
        if (option == "days")
          CommonTextField(
            icon: Icons.timer,
            controller: _daysController,
            hintText: "Provide the number of days",
            keyboardType: TextInputType.number,
            padding: const EdgeInsets.only(left: 15, right: 15),
          ),
        //  weeks
        RadioMenuButton(
          value: "weeks",
          groupValue: option,
          onChanged: (x) {
            setState(() {
              option = x ?? "";
            });
          },
          child: Text(
            "Weeks",
            style: TextStyles(context).getRegularStyle(),
          ),
        ),
        if (option == "weeks")
          CommonTextField(
            icon: Icons.timer,
            controller: _weeksController,
            hintText: "Provide the number of weeks",
            keyboardType: TextInputType.number,
            padding: const EdgeInsets.only(left: 15, right: 15),
          ),
        const Divider(),
        CommonButton(
          buttonText: "Save Changes",
          onTap: () {
            Routes.pop(context);
            // resolve complaint basing on either hours, minutes, days or weeks
            resolveComplaint(option, () {
              _hoursController.clear();
              _minutesController.clear();
              _daysController.clear();
              _weeksController.clear();
              showMessage(context:context,msg: "Duration ended for $option",type:'success');
            });
          },
          padding: const EdgeInsets.only(left: 15, right: 15),
        )
      ],
    );
  }

  // resolve complaint
  void resolveComplaint(String option, FutureOr<Null> Function()? onDurationEnd) {
    if (option == "hours") {
      // resolve complaint after hours
      final int hours = int.parse(_hoursController.text);
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
      final int minutes = int.parse(_minutesController.text);
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
      final int days = int.parse(_daysController.text);
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
      final int weeks = int.parse(_weeksController.text);
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
}
