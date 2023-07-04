// ignore_for_file: non_constant_identifier_names

import '/exports/exports.dart';

class ViewReports extends StatefulWidget {
  // final String property_id;
  const ViewReports({Key? key}) : super(key: key);

  @override
  State<ViewReports> createState() => _ViewReportsState();
}

class _ViewReportsState extends State<ViewReports>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ComplaintsController>(context).setComplaints();
    _controller = AnimationController(
        vsync: this, value: 0, duration: const Duration(milliseconds: 900));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  List<QueryDocumentSnapshot<Map<String, dynamic>>> pending = [];

  EdgeInsets padding =
      const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 2);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ComplaintsController>(context).setComplaints();
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              topPadding: 50,
              titleText: "Pending Complaints",
              iconData: Icons.arrow_back,
              onBackClick: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("complaints")
                    .where("property_id",
                        isEqualTo: context.read<PropertyIdController>().state)
                    .snapshots(),
                builder: (context, snap) {
                          if(snap.hasData){
             pending = snap.data!.docs.where((element) => element.data()['status'] == "Pending").toList();
            }
                  return snap.hasData == false
                      ? const Loader(
                          text: "Raised complaints",
                        )
                      : snap.data!.docs.isEmpty
                          ? const NoDataWidget(text: "No Complaints flagged...")
                          : ListView(
                              children: List.generate(
                                pending.length,
                                (index) => TapEffect(
                                  onClick: () {
                                    context
                                        .read<MainController>()
                                        .captureTenantId(pending[index]
                                            ['tenant_id']);
                                    Routes.push(
                                      ComplaintProfile(
                                        id:pending[index].id,
                                        date: pending[index]['date'],
                                        title: pending[index]['title'],
                                        description: pending[index]
                                            ['description'],
                                        status: pending[index]
                                            ['status'],
                                        image: pending[index]['image'],
                                        tenantId: pending[index]
                                            ['tenant_id'],
                                      ),
                                      context,
                                    );
                                  },
                                  child: SettingCard(
                                    padding: padding,
                                    titleText:
                                        "${pending[index]['title']}",
                                    subText: "Tap to view details",
                                    leading: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        backgroundImage: MemoryImage(
                                          base64.decode(
                                            pending[index]['image'],
                                          ),
                                        ),
                                        radius: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
