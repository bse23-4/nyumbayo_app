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
              child: ListView(
                children: List.generate(
                  20,
                  (index) => TapEffect(
                    onClick: () {
                      Routes.push(const ComplaintProfile(), context);
                    },
                    child: SettingCard(
                      padding: padding,
                      titleText: "John Doe",
                      subText: "Tap to view details",
                      leading: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person),
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
    );
  }
}
