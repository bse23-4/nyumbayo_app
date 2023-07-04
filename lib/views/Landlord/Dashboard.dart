// import 'package:flutter/cupertino.dart';

import '../../controllers/TenantController.dart';
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
    // fetching tenants 
    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<PropertyIdController>().state);
        // fetching property
    BlocProvider.of<PropertyController>(context).fetchProperties();
    // fetching property id
    BlocProvider.of<PropertyIdController>(context).getPropertyId();
    // setting the amount
    Provider.of<MainController>(context, listen: false)
        .setAmount(context.read<PropertyIdController>().state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<PropertyIdController>().state);
    BlocProvider.of<PropertyController>(context).fetchProperties();
    Provider.of<MainController>(context, listen: false)
        .setAmount(context.read<PropertyIdController>().state);

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
          .collection("property")
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
// fetching property
    BlocProvider.of<PropertyController>(context).fetchProperties();
// fetching property id
    BlocProvider.of<PropertyIdController>(context).getPropertyId();

    Provider.of<MainController>(context, listen: true)
        .setAmount(context.read<PropertyIdController>().state);
// listen to incoming notifications

// 
    context
        .watch<MainController>()
        .fetchComplaints(context.read<PropertyIdController>().state);

        // fetching resolved complaints 
          context
        .watch<MainController>()
        .fetchResolvedComplaints(context.read<PropertyIdController>().state);
    getPropertyName(context.read<PropertyIdController>().state);
    List<Map<String, dynamic>> data = [
      {
        "title": "Tenants",
        "total": BlocProvider.of<TenantController>(context).state.length,
        "route": Routes.tenants,
        "color": Colors.green.shade200,
      },
      {
        "title": "Pending Complaints",
        "total": context.watch<MainController>().complaints.length,
        "route": Routes.complaints,
        "color": Colors.orangeAccent.shade200,
      },
      {
        "title": "Resolved Complaints",
        "total": context.watch<MainController>().resolved_complaints.length,
        "route": Routes.resolved,
        "color": Colors.blue.shade200,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.blue[800],
        actions: [
          // Dropdown for property
          PopupMenuButton(
            iconSize: 20,
            // dropdown menu builder
            itemBuilder: (context) => List.generate(
              BlocProvider.of<PropertyController>(context).state.length,
              (index) => PopupMenuItem(
                // display property name
                child: Text(
                    "${BlocProvider.of<PropertyController>(context).state[index]['name']}"),
                onTap: () {
                  selectedProperty =
                      BlocProvider.of<PropertyController>(context).state[index]
                          ['name'];

                  BlocProvider.of<PropertyIdController>(context).setPropertyId(
                      BlocProvider.of<PropertyController>(context)
                          .state[index]
                          .id);

                  // show an alert message when a property is changed
                  showMessage(
                      context: context,
                      msg:
                          "Your now viewing ${BlocProvider.of<PropertyController>(context).state[index]['name']}'s data",
                      type: 'success');
                },
              ),
            ),
            // display selected property
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 8.0, top: 8, bottom: 8, left: 8),
              child: Row(
                children: [
                  Text(property, style: const TextStyle(color: Colors.white)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance
      .collection('complaints')
      .orderBy('date', descending: true)
      .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          //  context.watch<MainController>().listenToNewComplaints(snapshot.data!);
          }
          return Body(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: BlocBuilder<AmountController, double>(
                        builder: (context, state) {
                          return RichText(
                            // text to display the amoiunt collected changes
                            text: TextSpan(
                              text:
                                  "UGX ${formatNumberWithCommas(context.watch<MainController>().amt.toInt())}\n",
                              style: TextStyles(context)
                                  .getBoldStyle()
                                  .copyWith(fontSize: 40, color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Available collections",
                                  style: TextStyles(context)
                                      .getRegularStyle()
                                      .copyWith(fontSize: 19,color:Colors.white),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        // shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(
                              data.length,
                              (index) => 


                              // dashboard cards
                              TapEffect(
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


                                          // card title
                                          text: TextSpan(
                                            text: data[index]["title"],
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                            children: [


                                              // figures
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
                          // shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 18.0, right: 10, bottom: 8, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Text(
                                        "Payment Stats",
                                        style: TextStyle(color: Colors.black,fontSize:19),
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
                              // icon for bar chart.
                              const Icon(Icons.bar_chart,size:140)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
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
