// import 'package:flutter/cupertino.dart';

import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> data = [
    {
      "title": "Tenants",
      "total": 0,
      "route":Routes.tenants,
      "color": Colors.green.shade200,
    },
    {
      "title": "Complaints",
      "total": 0,
      "route":Routes.complaints,
      "color": Colors.blue.shade200,
    },
    {
      "title": "Properties",
      "route":Routes.properties,
      "total": 0,
      "color": Colors.red.shade200,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
              ))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          data.length,
          (index) => TapEffect(
            onClick: () => Navigator.of(context).pushNamed(data[index]['route']),
            child: Card(
              color: data[index]["color"],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: data[index]["title"],
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: Colors.black, fontSize: 20),
                        children: [
                          TextSpan(
                            text: "\n ${data[index]['total']}",
                            style: TextStyles(context)
                                .getBoldStyle()
                                .copyWith(color: Colors.black, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showOptions(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
