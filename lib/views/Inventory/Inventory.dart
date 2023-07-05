import '/exports/exports.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class Inventory extends StatefulWidget {
  final String amountPaid;
  final String date;
  final String paymentMode;
  final String balance;
  final String property;
  final String paymentStatus;
  final String tenantName;


  const Inventory(
      {Key? key,
      required this.amountPaid,
      required this.date,
      required this.paymentMode,
      required this.property,
      required this.paymentStatus,
      required this.tenantName, required this.balance})
      : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("payments").snapshots(),
          builder: (context, snapshot) {
            context.read<MainController>().propertyName(widget.property);
            return !snapshot.hasData
                ? const Loader(
                    text: "Loading inventory data..",
                  )
                : snapshot.data!.docs.isEmpty
                    ? const NoDataWidget(
                        text: "No inventory data available.",
                      )
                    :
                     PdfPreview(
                        initialPageFormat: PdfPageFormat.standard,
                        build: (format) => pdfFile(format, {
                          "amountPaid": widget.amountPaid,
                          "date": widget.date,
                          "paymentMode": widget.paymentMode,
                          "property": context.read<MainController>().property,//.propertyName(widget.property),
                          "paymentStatus": widget.paymentStatus,
                          "balance":widget.balance,
                          "tenantName": widget.tenantName

                        }
                            // snapshot.data!.docs[0].data(),
                            ),
                        pdfFileName: "Inventory",
                      );
          }),
    );
  }
}
