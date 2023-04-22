import 'package:nyumbayo_app/exports/exports.dart';

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
              iconData: Icons.arrow_back,
              headerWidget: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  const SizedBox(width: 30,),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                            CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                      radius: 45,
                      child: Icon(Icons.person),
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
              title: Text("Amount paid", style: TextStyles(context).getBoldStyle()),
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
            ListTile(
                leading: const Icon(
                  Icons.attach_money_outlined,
                  size: 35,
                ),
                title: Text("Issue Snapshot",
                    style: TextStyles(context).getBoldStyle()),
                subtitle: const FlutterLogo(
                  size: 90,
                )),
            const Divider(),
            const Space(space: 0.04),
            CommonButton(
              buttonText: "Resolve",
              height: 55,
              backgroundColor: Colors.green.shade500,
              padding: padding,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.width / 6,
                        child: const Dialog(
                          child: Center(child: Text("hshsh")),
                        ),
                      );
                    });
              },
            ),
            const Space(space: 0.02),
            CommonButton(
              buttonText: "Reject",
              height: 55,
              backgroundColor: Colors.red.shade500,
              padding: padding,
            )
          ],
        ),
      ),
    );
  }
}
