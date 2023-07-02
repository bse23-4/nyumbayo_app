import '/exports/exports.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  
  @override
  Widget build(BuildContext context) {
     // settings power status
    Provider.of<MainController>(context)
        .setPower(context.read<UserdataController>().state);
    // power consumed
    context.watch<MainController>().fetchPowerConsumed();
    BlocProvider.of<UserdataController>(context).getUserData();
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Hi ${context.read<TenantController>().state.isNotEmpty ? context.read<TenantController>().state['name'].split(" ")[1] : ''}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Text("Power Status", style: TextStyles(context).getBoldStyle()),
                  // power status
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(),
                        GlowContainer(
                          animationDuration: const Duration(milliseconds: 500),
                          animationCurve: Curves.easeInSine,
                          spreadRadius: 0.3,
                          glowColor: context.watch<MainController>().power
                              ? Colors.green
                              : Colors.red,
                          child: Badge(
                            largeSize: 240,
                            smallSize: 18,
                            backgroundColor: context.watch<MainController>().power
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        Text(
                          context.watch<MainController>().power == true
                              ? "ON"
                              : "OFF",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
  }
}