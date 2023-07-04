import 'dart:math';

import 'package:nyumbayo_app/exports/exports.dart';

class MonthlyCollection {
  final String property;
  final double collection;
  final Color color;

  MonthlyCollection(this.property, this.collection, this.color);
}

class MonthlyCollectionChart extends StatelessWidget {
  final List<MonthlyCollection> data;

  const MonthlyCollectionChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          width: 200,
          height: MediaQuery.of(context).size.width,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, x) {
                      return Transform.translate(
                        offset: const Offset(-20, 36),
                        child: Transform.rotate(
                          angle: -45,
                          child: Text(
                            formatDate(
                              DateTime.parse(data[value.toInt()].property),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // leftTitles: SideTitles(
                //   showTitles: true,
                //   textStyle: TextStyle(color: Colors.black),
                //   margin: 16,
                // ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black),
              ),
              barGroups: data
                  .asMap()
                  .map((index, collection) => MapEntry(
                      index,
                      BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            borderRadius: BorderRadius.zero,
                            width: 20,
                            color: data[index].color,
                            toY: collection.collection,
                          ),
                        ],
                      )))
                  .values
                  .toList(),
            ),
          ),
        ),
        const Space(space: 0.13),
        SizedBox(
          height: 250,
          child: Column(
            children: List.generate(
              data.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDate(
                        DateTime.parse(data[index].property),
                      )
                    ),
                   
                    Text(
                      data[index].collection.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Space(space: 0.13),
      ],
    );
  }
}

class LegendIcon extends StatelessWidget {
  final Color color;
  final double size;

  const LegendIcon({super.key, required this.color, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class MonthlyPropertyCollection extends StatefulWidget {
  const MonthlyPropertyCollection({super.key});

  @override
  State<MonthlyPropertyCollection> createState() =>
      _MonthlyPropertyCollectionState();
}

class _MonthlyPropertyCollectionState extends State<MonthlyPropertyCollection> {
  String x = "";
  @override
  Widget build(BuildContext context) {
    List<MonthlyCollection> collectionData = [];

    FirebaseFirestore.instance
        .collection("property")
        .doc(context.read<PropertyIdController>().state)
        .get()
        .then((value) {
      setState(() {
        x = value.data()?['name'] ?? "";
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Collections for $x'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('payments')
                .where("property",
                    isEqualTo: context.read<PropertyIdController>().state)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader(text: "monthly collections");
              } else {
                var d = snapshot.data!.docs;
                collectionData = List.generate(
                  d.length,
                  (index) => MonthlyCollection(
                      d[index].data()['date'],
                      double.parse(d[index].data()['amountPaid']),
                      Theme.of(context).primaryColor),
                );
              }
              return snapshot.data!.docs.isNotEmpty
                  ? MonthlyCollectionChart(collectionData)
                  : const NoDataWidget(text: "There's nothing here..");
            }),
      ),
    );
  }
}
