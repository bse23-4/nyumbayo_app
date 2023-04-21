import 'dart:io';

import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Dashboard"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Card(
              child: RichText(
                text: TextSpan(
                    text: "Tenants",
                    style: TextStyles(context).getRegularStyle().copyWith(color: Colors.black)),
              ),
            ),
          )
        ],
      ),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
