import '../../../controllers/PowerBillController.dart';
import '../../payments/payment.dart';
import '/exports/exports.dart';

class MiniDashBoard extends StatefulWidget {
  const MiniDashBoard({super.key});

  @override
  State<MiniDashBoard> createState() => _MiniDashBoardState();
}

class _MiniDashBoardState extends State<MiniDashBoard> {
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
    // double powerxPercentage = ((amountPaid + powerFee) / (amountToPay + powerFee)) * 100;
    // logic for tunning oof power
    BlocProvider.of<PowerBillController>(context).setSavePowerBill(context.watch<MainController>().computeBill(context.watch<MainController>().powerConsumed));
    return
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
                      "${separateZerosWithCommas(context.read<TenantController>().state['balance'])}/=",
                  color: percentage < 80 ? Colors.orangeAccent : Colors.white,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                ),
                DashTile(
                    title: "Units consumed",
                    value:
                        "${context.watch<MainController>().powerConsumed} kWh"),
                const Space(space: 0.01),
                BlocBuilder<PowerBillController, double>(
                  builder: (context, powerBill) {
                    return DashTile(
                        title: "Power bills", value: "$powerBill/=");
                  },
                ),
                const Space(space: 0.01),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white,
                            )),
                        child: const Text(
                          "Make payment",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // circle decoration
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          color: Colors.blue.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side:
                                const BorderSide(color: Colors.white, width: 5),
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
    );
    // end of complaint tab
  }
}
