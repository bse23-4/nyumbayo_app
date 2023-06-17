// import 'package:flutter/cupertino.dart';

import '/exports/exports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<PropertyIdController>().state);
    BlocProvider.of<PropertyController>(context).fetchProperties();
    BlocProvider.of<PropertyIdController>(context).getPropertyId();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<PropertyIdController>().state);
    BlocProvider.of<PropertyController>(context).fetchProperties();
  //  
    BlocProvider.of<PropertyIdController>(context).getPropertyId();
  // 


  }

  String property = "";

// property variable
  String? selectedProperty;
  void getPropertyName(String id) {
    if (id == "") {
      property = "Select a property";
    } else {
      FirebaseFirestore.instance
          .collection("properties")
          .doc(id)
          .get()
          .then((value) {
        setState(() {
          property = value.data()?['name'] ?? "";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TenantController>(context, listen: true)
        .fetchTenants(context.read<PropertyIdController>().state);
    BlocProvider.of<PropertyController>(context).fetchProperties();
    BlocProvider.of<PropertyIdController>(context).getPropertyId();
    BlocProvider.of<AmountController>(context).setAmount();
 
    getPropertyName(context.read<PropertyIdController>().state);
    List<Map<String, dynamic>> data = [
      {
        "title": "Tenants",
        "total": BlocProvider.of<TenantController>(context).state.length,
        "route": Routes.tenants,
        "color": Colors.green.shade200,
      },
      {
        "title": "Complaints",
        "total": context.watch<MainController>().complaints.length,
        "route": Routes.complaints,
        "color": Colors.blue.shade200,
      },
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          PopupMenuButton(
            iconSize: 20,
            itemBuilder: (context) => List.generate(
              BlocProvider.of<PropertyController>(context).state.length,
              (index) => PopupMenuItem(
                child: Text(
                    "${BlocProvider.of<PropertyController>(context).state[index]['name']}"),
                onTap: () {
                  setState(() {
                    selectedProperty =
                        BlocProvider.of<PropertyController>(context)
                            .state[index]['name'];
                  });
                  BlocProvider.of<PropertyIdController>(context).setPropertyId(
                      BlocProvider.of<PropertyController>(context)
                          .state[index]
                          .id);
                },
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 8.0, top: 8, bottom: 8, left: 8),
              child: Row(
                children: [
                  Text(property),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          )
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
                child: BlocBuilder<AmountController, double>(
                  builder: (context, state) {
                    return RichText(
                      text: TextSpan(
                        text: "UGX ${formatNumberWithCommas(state.toInt())}\n",
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(fontSize: 40, color: Colors.white),
                        children: [
                          TextSpan(
                              text: "Available collections",
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(fontSize: 19))
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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
                                height: 150,
                                width: 150,
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: data[index]["title"],
                                      style: TextStyles(context)
                                          .getRegularStyle()
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: "\n ${data[index]['total']}",
                                          style: TextStyles(context)
                                              .getBoldStyle()
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 29),
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
              const Space(space: 0.02),
              TapEffect(
                onClick: () {
                  Routes.named(context, Routes.stats);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0, right: 10, bottom: 8, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                     "Payment Summary",
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(color: Colors.black),
                                ),
                              ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(
                                      "View all",
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(color: Colors.blue.shade900),
                                    ),
                               )
                            ],
                          ),
                        ),
                       Chart()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed(Routes.addTenant),
        label: const Text("Add Tenant"),
        icon: const Icon(Icons.person_add_rounded),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
