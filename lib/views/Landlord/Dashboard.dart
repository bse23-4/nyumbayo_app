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
      "route": Routes.tenants,
      "color": Colors.green.shade200,
    },
    {
      "title": "Complaints",
      "total": 0,
      "route": Routes.complaints,
      "color": Colors.blue.shade200,
    },
    {
      "title": "Properties",
      "route": Routes.payment,
      "total": 0,
      "color": Colors.red.shade200,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
              ))
        ],
      ),
      body: Body(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: RichText(
                  text:  TextSpan(
                    text: "UGX 3,000,000\n",style: TextStyles(context).getBoldStyle().copyWith(fontSize: 30,color: Colors.white),
                    children: [
                      TextSpan(text: "Available collections",style: TextStyles(context).getRegularStyle().copyWith(fontSize: 19))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        data.length,
                        (index) => TapEffect(
                          onClick: () => Navigator.of(context)
                              .pushNamed(data[index]['route']),
                          child: Card(
                            color: data[index]["color"],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: data[index]["title"],
                                      style: TextStyles(context)
                                          .getRegularStyle()
                                          .copyWith(
                                              color: Colors.black, fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: "\n ${data[index]['total']}",
                                          style: TextStyles(context)
                                              .getBoldStyle()
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 19),
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
                  ),
                ),
              ),
            ],
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
