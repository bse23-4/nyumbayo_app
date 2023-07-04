import 'package:nyumbayo_app/exports/exports.dart';

class PowerConnection {
  final String property;
  final double collection;
  final Color color;

  PowerConnection(this.property, this.collection, this.color);
}

class TenantConnectionChart extends StatelessWidget {
  final List<PowerConnection> data;

  const TenantConnectionChart(this.data, {super.key});

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
                            data[value.toInt()].property,
                            style: TextStyles(context).getDescriptionStyle(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
          width: 160,
          child: Card(
            child: SizedBox(
              height: 120,
              child: Column(
                children: List.generate(
                  data.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LegendIcon(color: data[index].color),
                      const SizedBox(width: 4),
                      Text(
                        data[index].property,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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

class TenantChartScreen extends StatefulWidget {
  const TenantChartScreen({super.key});

  @override
  State<TenantChartScreen> createState() => _TenantChartScreenState();
}

class _TenantChartScreenState extends State<TenantChartScreen> {
  String x = "";
  double connected = 0.0;
  double disconnected = 0.0;
  @override
  Widget build(BuildContext context) {
    List<PowerConnection> collectionData = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats power status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tenants')
                .where("property",
                    isEqualTo: context.read<PropertyIdController>().state)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader(text: "Disconnection data",);
              } else {
                var d = snapshot.data!.docs;

                connected = d
                    .where((element) => element.data()['power_status'] == 'on')
                    .toList()
                    .length
                    .toDouble();
                disconnected = d
                    .where((element) => element.data()['power_status'] == 'off')
                    .toList()
                    .length
                    .toDouble();

                collectionData = [
                  PowerConnection("Connected", connected, Colors.green),
                  PowerConnection("Disconnected", disconnected, Colors.red)
                ];
              }
              return snapshot.data!.docs.isNotEmpty
                  ? TenantConnectionChart(collectionData)
                  : const NoDataWidget(text: "No data available");
            }),
      ),
    );
  }
}
