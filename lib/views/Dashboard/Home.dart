import '/exports/exports.dart';
import 'package:nyumbayo_app/views/payments/payment.dart';

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
    Provider.of<MainController>(context)
        .setPower(context.read<UserdataController>().state);
       
    BlocProvider.of<UserdataController>(context).getUserData();
    BlocProvider.of<TenantController>(context, listen: true)
        .fetchTenants(context.read<UserdataController>().state);
    // computations for balance
    // int balance = int.parse(context.read<TenantController>().state['balance']);
    int powerFee =
        int.parse(context.read<TenantController>().state['power_fee'] ?? "0");
    int amountPaid =
        int.parse(context.read<TenantController>().state['amountPaid'] ?? "0");
    int amountToPay =
        int.parse(context.read<TenantController>().state['monthlyRent'] ?? "0");
    // computes percentage
    double percentage =
        ((amountPaid + powerFee) / (amountToPay + powerFee)) * 100;
         // logic for tunning oof power
        Provider.of<MainController>(context)
        .controlPower(context.read<UserdataController>().state,percentage.toInt());
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        "Hi ${context.read<TenantController>().state['name'].split(" ")[0] ?? ''},",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

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
                            backgroundColor:
                                context.watch<MainController>().power
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
                  height: MediaQuery.of(context).size.width * 0.483,
                  child: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 18.0, left: 18),
                          child: Text(
                            "Balances",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        const Space(space: 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Text(
                                "Rent",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(
                                "UGX ${context.read<TenantController>().state['balance']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Text(
                                "Electricity",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(
                                "UGX ${context.read<TenantController>().state['power_fee']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
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
                                    fontWeight: FontWeight.w800,
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
                padding: const EdgeInsets.all(18.0),
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
                      "Rent & Electricity",
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
                                "\t UGX ${int.parse(context.read<TenantController>().state['amountPaid']) + int.parse(context.read<TenantController>().state['power_fee'])}",
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "No completed balance",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
