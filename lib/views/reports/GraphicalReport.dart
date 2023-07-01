import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    return LineChart(
      LineChartData(
        lineTouchData: const LineTouchData(enabled: true),
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (x, value) {
                return Text(data[x.toInt()].month);
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
      duration:const Duration(milliseconds:900),
      curve: Curves.easeInCubic,
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
    final List<MonthlyPayment> paymentData = [
      MonthlyPayment('Jan', 500),
      MonthlyPayment('Feb', 550),
      MonthlyPayment('Mar', 600),
      MonthlyPayment('Apr', 700),
      MonthlyPayment('May', 650),
      MonthlyPayment('Jun', 750),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Payment Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: LineGraph(paymentData),
        ),
      ),
    );
  }
}
