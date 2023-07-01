import 'package:nyumbayo_app/views/Inventory/Preview.dart';
import 'package:nyumbayo_app/views/reports/GraphicalReport.dart';

import '../Inventory/Inventory.dart';
import '/exports/exports.dart';
import '/views/payments/payment.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    BlocProvider.of<UserdataController>(context).getUserData();
    context
        .read<MainController>()
        .setPower(context.read<UserdataController>().state);
    context.read<MainController>().fetchPowerConsumed();
    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<UserdataController>().state);
    super.initState();
    _controller = AnimationController(
        vsync: this, value: 0, duration: const Duration(seconds: 1));
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

// String user =  FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // settings power status
    Provider.of<MainController>(context)
        .setPower(context.read<UserdataController>().state);
    // power consumed
    context.watch<MainController>().fetchPowerConsumed();
    BlocProvider.of<UserdataController>(context).getUserData();
    BlocProvider.of<TenantController>(context, listen: true)
        .fetchTenants(context.read<UserdataController>().state);
    // computations for balance
    // int balance = int.parse(context.read<TenantController>().state['balance']);
    int amountPaid =
        int.parse(context.read<TenantController>().state['amountPaid'] ?? "0");
    int amountToPay =
        int.parse(context.read<TenantController>().state['monthlyRent'] ?? "0");
    // computes percentage
    double percentage = ((amountPaid) / (amountToPay)) * 100;
    // compute percentage for electricity
    // double powerPercentage = ((amountPaid + powerFee) / (amountToPay + powerFee)) * 100;
    // logic for tunning oof power
    if ((percentage.isNaN == false && percentage >= 80)) {
      Provider.of<MainController>(context, listen: true).controlPower(
          context.read<UserdataController>().state, percentage.toInt(),
          x: 1);
    } else if ((percentage.isNaN == false && percentage < 80)) {
      Provider.of<MainController>(context, listen: true).controlPower(
          context.read<UserdataController>().state, percentage.toInt(),
          x: 0);
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Hi ${context.read<TenantController>().state['name'] ?? " ".split(" ")[0] ?? ''},",
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
          ),
          // complaint tab
          TapEffect(
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PaymentScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 19.0, right: 19.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.6683,
                child: Card(
                  color: Colors.blue.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 18),
                        child: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      const Space(space: 0.02),
                      DashTile(
                          title: "Rent Balance",
                          value:
                              "${context.read<TenantController>().state['balance']}/="),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.03,
                      ),
                      DashTile(
                          title: "Units consumed",
                          value:
                              "${context.watch<MainController>().powerConsumed} kWh"),
                      const Space(space: 0.01),
                      DashTile(
                          title: "Electricity",
                          value:
                              "${context.watch<MainController>().computeBill(context.watch<MainController>().powerConsumed)}/="),
                      const Space(space: 0.01),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Click here to make payment",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Card(
                                color: Colors.blue.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(
                                      color: Colors.white, width: 5),
                                ),
                                child: const SizedBox(
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // pending balances
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Pending Balance",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          if (context.read<TenantController>().state['balance'] != "0")
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${percentage.toStringAsFixed(1)} %",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  title: const Text(
                    "Rent Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: const Text("Please pay your dues"),
                  trailing: RichText(
                    text: TextSpan(
                      text: "Paid",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      children: [
                        TextSpan(
                          text:
                              "\t UGX ${int.parse(context.read<TenantController>().state['amountPaid'] ?? "0") + int.parse(context.read<TenantController>().state['power_fee'] ?? "0")}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const TextSpan(
                          text: "\nDue on 30/09/2021",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (context.read<TenantController>().state['balance'] != "0")
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.electric_bolt_sharp,
                    color: Colors.blue.shade600,
                    size: 40,
                  ),
                  title: const Text(
                    "Electricity Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: const Text("Please pay your dues"),
                  trailing: RichText(
                    text: TextSpan(
                      text: "Paid",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      children: [
                        TextSpan(
                          text:
                              "\t UGX ${int.parse(context.read<TenantController>().state['power_fee'] ?? "0")}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const TextSpan(
                          text: "\nDue on 30/09/2021",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (context.read<TenantController>().state['balance'] == "0")
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "No pending balance",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Completed Balance",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          if (context.read<TenantController>().state['balance'] == "0")
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("$percentage%"),
                  ),
                  title: const Text(
                    "Rent & Electricity",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text(
                    "Thank you for paying",
                  ),
                  trailing: const Text(
                    "UGX 0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          if (context.read<TenantController>().state['balance'] != "0")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "No completed balance",
                  style: TextStyles(context).getRegularStyle().copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                heroTag: null,
                icon: const Icon(Icons.analytics),
                   onPressed: () => Routes.push(const GraphicalReport(), context),
                label: const Text("Analytics"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () => Routes.push(const Preview(), context),
                label: const Text("Inventory"),
                icon: const Icon(Icons.inventory),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
