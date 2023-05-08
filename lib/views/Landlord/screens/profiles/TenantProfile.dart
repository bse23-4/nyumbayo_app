import '/exports/exports.dart';

class TenantProfile extends StatefulWidget {
  const TenantProfile({super.key});

  @override
  State<TenantProfile> createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
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
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonAppbarView(
              headerWidget: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 30,
                      child: IconButton(
                          onPressed: () => Routes.pop(context),
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 45,
                          child: const Icon(
                            Icons.person,
                            size: 55,
                          ),
                        ),
                        const Space(space: 0.04),
                        RichText(
                          text: TextSpan(
                            text: "John Doe\n",
                            style: TextStyles(context)
                                .getBoldStyle()
                                .copyWith(fontSize: 20),
                            children: [
                              TextSpan(
                                text: "john@gmail.com",
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
                    const SizedBox(width: 50),
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
                "UGX 2,00,000",
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
                "Description",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            const Divider(),
            BlocBuilder<PowerConnectionController, bool>(
              builder: (context, state) => SwitchListTile.adaptive(
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
                               const Icon(Icons.warning_amber_rounded,size: 40,color: Colors.amber,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                   state == false? "Confirm turning on the power?" :"Confirm turning off the power?",
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Routes.pop(context);
                                          context.read<PowerConnectionController>().setPowerState(!state);
                                        },
                                        child: Text(
                                         state == false? "Turn on": "Turn off",
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
                  state == false
                      ? "Power connection off"
                      : "Power connection on",
                ),
              ),
            ),
            const Space(space: 0.04),
          ],
        ),
      ),
    );
  }
}
