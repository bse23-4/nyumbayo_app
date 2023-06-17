import '/exports/exports.dart';

class ViewReports extends StatefulWidget {
  const ViewReports({super.key});

  @override
  State<ViewReports> createState() => _ViewReportsState();
}

class _ViewReportsState extends State<ViewReports>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ComplaintsController>(context).setComplaints();
    _controller = AnimationController(
        vsync: this, value: 0, duration: const Duration(milliseconds: 900));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EdgeInsets padding =
      const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 2);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ComplaintsController>(context).setComplaints();
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              topPadding: 10,
              titleText: "Complaints",
              iconData: Icons.arrow_back,
              onBackClick: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: Database.fetchAll("complaints"),
                builder: (context, snap) {
                  return snap.hasData == false
                      ? const Loader(
                          text: "Raised complaints",
                        )
                      : ListView(
                          children: List.generate(
                            snap.data!.length,
                            (index) => TapEffect(
                              onClick: () {
                                Routes.push(const ComplaintProfile(), context);
                              },
                              child: SettingCard(
                                padding: padding,
                                titleText: "${snap.data![index]['title']}",
                                subText: "Tap to view details",
                                leading: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      base64.decode(
                                        snap.data![index]['image'],
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
