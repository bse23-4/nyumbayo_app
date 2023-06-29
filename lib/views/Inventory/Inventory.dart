import '/exports/exports.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

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
            return !snapshot.hasData
                ? const Loader(
                    text: "Loading inventory data..",
                  )
                : snapshot.data!.docs.isEmpty
                    ? const NoDataWidget(
                        text: "No inventory data available.",
                      )
                    : PdfPreview(
                        initialPageFormat: PdfPageFormat.standard,
                        build: (format) => pdfFile(
                          format,{}
                          // snapshot.data!.docs[0].data(),
                        ),
                        pdfFileName: "inventory.pdf",
                      );
          }),
    );
  }
}
