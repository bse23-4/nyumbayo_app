import 'package:fl_chart/fl_chart.dart';
import 'package:nyumbayo_app/exports/exports.dart';

class MonthlyPayment {
  final String month;
  final double payment;

  MonthlyPayment(this.month, this.payment);
}

class LineGraph extends StatelessWidget {
  final List<MonthlyPayment> data;

  const LineGraph(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: true),
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: (x, value) {
                    return Transform.translate(
                      offset: const Offset(10, 40),
                      child: Transform.rotate(
                        angle: 45,
                        child: Text(
                          formatDate(
                            DateTime.parse(data[x.toInt()].month),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // leftTitles: const AxisTitles(
            //   sideTitles: SideTitles(  // <-- HERE
            //     showTitles: true,
            //   ),
            // )),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: data
                    .asMap()
                    .entries
                    .map((entry) =>
                        FlSpot(entry.key.toDouble(), entry.value.payment))
                    .toList(),
                isCurved: true,
                barWidth: 2,
                dotData: const FlDotData(show: true),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInCubic,
        ),
      ],
    );
  }
}

class GraphicalReport extends StatefulWidget {
  const GraphicalReport({super.key});

  @override
  State<GraphicalReport> createState() => _GraphicalReportState();
}

class _GraphicalReportState extends State<GraphicalReport> {
  @override
  Widget build(BuildContext context) {
    List<MonthlyPayment> paymentData = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Payment Graph'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("payments")
            .where("tenantId",
                isEqualTo: context.read<UserdataController>().state)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var d = snapshot.data?.docs;
            paymentData = List.generate(
              d!.length,
              (x) => MonthlyPayment(
                  d[x].data()['date'], double.parse(d[x].data()['amountPaid'])),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: 200,
                  child: LineGraph(paymentData),
                ),
                const Space(space: 0.08),
                const ListTile(
                  title: Text(
                    "Dates of Payment",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Text(
                    "Amount paid",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const Divider(),
                ...List.generate(
                  paymentData.length,
                  (index) => ListTile(
                    title: Text(
                      formatDate(
                        DateTime.parse(paymentData[index].month),
                      ),
                      style:  TextStyles(context).getRegularStyle().copyWith(fontSize: 16),
                    ),
                    subtitle: Text(
                      formatTime(
                        DateTime.parse(paymentData[index].month),
                      ),
                      style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16),
                    ),
                    trailing: Text(
                      paymentData[index].payment.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
