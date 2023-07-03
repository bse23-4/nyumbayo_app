// ignore_for_file: non_constant_identifier_names

import '/exports/exports.dart';

class ViewResolvedReports extends StatefulWidget {
  // final String property_id;
  const ViewResolvedReports({Key? key}) : super(key: key);

  @override
  State<ViewResolvedReports> createState() => _ViewResolvedReportsState();
}

class _ViewResolvedReportsState extends State<ViewResolvedReports>
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

  List<QueryDocumentSnapshot<Map<String, dynamic>>> resolved = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              titleText: "Resolved Complaints",
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
                  if (snap.hasData) {
                    resolved = snap.data!.docs
                        .where(
                            (element) => element.data()['status'] == "Resolved")
                        .toList();
                  }
                  return snap.hasData == false
                      ? const Loader(
                          text: "Raised complaints",
                        )
                      : snap.data!.docs.isEmpty
                          ? const NoDataWidget(text: "No Complaints flagged...")
                          : ListView(
                              children: List.generate(
                                resolved.length,
                                (index) => TapEffect(
                                  onClick: () {
                                    context
                                        .read<MainController>()
                                        .captureTenantId(
                                            resolved[index]['tenant_id']);
                                    Routes.push(
                                      ComplaintProfile(
                                        date: resolved[index]['date'],
                                        title: resolved[index]['title'],
                                        description: resolved[index]
                                            ['description'],
                                        status: resolved[index]['status'],
                                        image: resolved[index]['image'],
                                        tenantId: resolved[index]['tenant_id'],
                                        id: resolved[index].id,
                                      ),
                                      context,
                                    );
                                  },
                                  child: SettingCard(
                                    padding: padding,
                                    titleText: "${resolved[index]['title']}",
                                    subText: "Tap to view details",
                                    leading: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        backgroundImage: MemoryImage(
                                          base64.decode(
                                            resolved[index]['image'],
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
