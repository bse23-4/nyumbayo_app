import '/tools/index.dart';
import '/exports/exports.dart';

class BottomMenu extends StatefulWidget {
final String id;
final String complaintId;
  const BottomMenu({Key? key, required this.id,required this.complaintId}):super(key:key);

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
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15 , bottom: 15, top: 15),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.only(left: 15, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon:const Icon(Icons.save),
            label:const Text( "Save Changes"),
            onPressed: () {
              Routes.pop(context);
              handleIssue(widget.id, widget.complaintId,"on", "Resolved",'');
              // resolve complaint basing on either hours, minutes, days or weeks
              resolveComplaint(option, [_hoursController, _minutesController, _daysController, _weeksController], () {
                _hoursController.clear();
                _minutesController.clear();
                _daysController.clear();
                _weeksController.clear();
                // execute this after specified time
                 handleIssue(widget.id,  widget.complaintId,"off", "Resolved",'Your time period has expired');
                // showMessage(context:context,msg: "Duration ended for $option",type:'success');
              });

              showMessage(context:context,msg:"Saved changes",type:'success');
            },
          ),
        )
      ],
    );
  }
}
// ltd@sunbird.ai