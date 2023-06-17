import 'package:nyumbayo_app/api/Api.dart';

import '/exports/exports.dart';

class TenantProfile extends StatefulWidget {
  final Map<String, dynamic> tenantDetails;
  final String id;
  const TenantProfile(
      {super.key, required this.tenantDetails, required this.id});

  @override
  State<TenantProfile> createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // BlocProvider.of<PowerConnectionController>(context)
    //     .getPowerState(widget.id);
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(
        milliseconds: 900,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EdgeInsets padding = const EdgeInsets.only(left: 20, right: 20);
  @override
  Widget build(BuildContext context) {
    // bool status = widget.tenantDetails["power_status"] == "on";
    // BlocProvider.of<PowerConnectionController>(context,listen: true)
    //     .getPowerState(widget.id);
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonAppbarView(
              headerWidget: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 40, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 45,
                          child: Text(
                            "${widget.tenantDetails['name'].toString().split(" ")[0].characters.first.trim()}${widget.tenantDetails['name'].toString().split(" ")[1].characters.first.trim().toUpperCase()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        const Space(space: 0.04),
                        RichText(
                          text: TextSpan(
                            text: "${widget.tenantDetails["name"]}\n",
                            style: TextStyles(context)
                                .getBoldStyle()
                                .copyWith(fontSize: 26),
                            children: [
                              TextSpan(
                                text: "${widget.tenantDetails["email"]}\n",
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.attach_money_outlined,
                size: 35,
              ),
              title: Text("Amount paid",
                  style: TextStyles(context).getBoldStyle()),
              subtitle: Text(
                "UGX ${widget.tenantDetails["amountPaid"]}",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.balance_outlined,
                size: 35,
              ),
              title: Text("Balance", style: TextStyles(context).getBoldStyle()),
              subtitle: Text(
                "UGX ${double.parse(widget.tenantDetails["monthlyRent"]) - double.parse(widget.tenantDetails["amountPaid"])}",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            const Divider(),
            BlocBuilder<PowerConnectionController, bool>(
              builder: (context, state) {
                return SwitchListTile.adaptive(
                  secondary: const Icon(Icons.power_settings_new,color: Colors.red ,),
                  value: state,
                  onChanged: (value) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 40,
                                    color: Colors.amber,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      state
                                          ? "Confirm turning off the power?"
                                          : "Confirm turning on the power?",
                                      style: TextStyles(context)
                                          .getRegularStyle()
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Routes.pop(context);
                                            context
                                                .read<
                                                    PowerConnectionController>()
                                                .setPowerState(
                                                    widget.id,!state);
                                                    Api.triggerPower(state == false ?1.toString():0.toString());
                                            // FirebaseFirestore.instance
                                            //     .collection("tenants")
                                            //     .doc(widget.id)
                                            //     .update({
                                            //   "landlord_power_control":
                                            //       state ? "off" : "on"
                                            // });
                                          },
                                          child: Text(
                                            state ? "Turn off" : "Turn on",
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(color: Colors.blue),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => Routes.pop(context),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(color: Colors.red),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  title: Text("Power Switch",
                      style: TextStyles(context).getBoldStyle()),
                  subtitle: Text(
                    state ? "Power connection on" : "Power connection off",
                  ),
                );
              },
            ),
            const Space(space: 0.04),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Routes.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
