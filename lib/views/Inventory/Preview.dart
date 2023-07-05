import 'package:nyumbayo_app/exports/exports.dart';

import 'Inventory.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments Preview"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("payments")
        .where("tenantId",isEqualTo: context.read<UserdataController>().state)
        .snapshots(),
        builder: (context, snapshot) {
          var result = snapshot.data;
          return snapshot.hasData
              ? result!.docs.isEmpty
                  ? const NoDataWidget(text: "No payments available")
                  : ListView.separated(
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                              "Amount currently paid: ${result.docs[i]["amountPaid"].toString()}"),
                          subtitle: Text(formatDateTime(DateTime.parse(
                              result.docs[i]["date"].toString()))),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Inventory(
                                  amountPaid:
                                      result.docs[i]["amountPaid"].toString(),
                                  date: formatDateTime(DateTime.parse(result.docs[i]["date"].toString())),
                                  paymentMode:
                                      result.docs[i]["paymentMode"].toString(),
                                      paymentStatus:double.parse(result.docs[i]["balance"].toString()) == 0 ? "Cleared" : "You have outsanding balances",
                                  property: (
                                      result.docs[i]["property"].toString()),
                                  tenantName:
                                      result.docs[i]["tenantName"].toString(),
                                  balance: result.docs[i]["balance"].toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (ctx, i) => const Divider(),
                      itemCount: result.docs.length)
              : const Loader(
                  text: "payment inventory",
                );
        },
      ),
    );
  }
}
