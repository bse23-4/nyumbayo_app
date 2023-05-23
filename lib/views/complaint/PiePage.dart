// ignore_for_file: file_names

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final int numberOfSectors;

  const PieChartWidget(this.numberOfSectors, {Key? key}) : super(key: key);

 @override
Widget build(BuildContext context) {
  final List<PieChartSector> sectors = _generateRandomSectors(numberOfSectors);
  final List<Widget> legendItems = _buildLegendItems(sectors);
  return Scaffold(
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the top
      children: [
        Expanded(
          flex: 1,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: PieChart(
              PieChartData(
                sections: _chartSections(sectors),
                centerSpaceRadius: 30.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to the left
            children: legendItems,
          ),
        ),
      ],
    ),
  );
}


  List<PieChartSectionData> _chartSections(List<PieChartSector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: sector.color,
        value: sector.value,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }

  List<PieChartSector> _generateRandomSectors(int numberOfSectors) {
    final Random random = Random();
    final List<PieChartSector> sectors = [];
    for (int i = 0; i < numberOfSectors; i++) {
      final Color color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      final double value = random.nextDouble() * 100;
      final String label = 'Sector ${i + 1}';
      sectors.add(PieChartSector(color, value, label));
    }
    return sectors;
  }

  List<Widget> _buildLegendItems(List<PieChartSector> sectors) {
    final List<Widget> legendItems = [];
    for (var sector in sectors) {
      final legendItem = Row(
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            color: sector.color,
          ),
          const SizedBox(width: 1.0),
          Text('${sector.label} (${sector.value.toStringAsFixed(1)})'),
        ],
      );
      legendItems.add(legendItem);
    }
    return legendItems;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pie Chart Widget'),
        ),
        body: const Center(
          child: PieChartWidget(5),
        ),
      ),
    );
  }
}

class PieChartSector {
  final Color color;
  final double value;
  final String label;

  PieChartSector(this.color, this.value, this.label);
}
