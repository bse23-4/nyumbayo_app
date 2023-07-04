// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';
import 'Disconnection.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final List<String> _data = [
    "Monthly property collections",
    "Disconnections reports",
    // "Tenant's Requests"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis Page"),
      ),
      body: ListView.separated(
        itemBuilder: (ctx, i) => ListTile(
          leading: const Icon(Icons.analytics, size: 30),
          title: Text(_data[i]),
          subtitle: Text("Click here to view more",
              style: TextStyles(context).getDescriptionStyle()),
          onTap: () {
            if (i == 0) {
              Routes.named(context, Routes.monthlyPropertyCollection);
            } else if (i == 1) {
              Routes.push(const TenantChartScreen(), context);
            } else {}
          },
        ),
        separatorBuilder: (ctx, i) => const Divider(),
        itemCount: _data.length,
      ),
    );
  }
}
