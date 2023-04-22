import '/exports/exports.dart';

class ViewTenants extends StatefulWidget {
  const ViewTenants({super.key});

  @override
  State<ViewTenants> createState() => _ViewTenantsState();
}

class _ViewTenantsState extends State<ViewTenants>
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
              topPadding: 20,
              titleText: "Tenants",
              iconData: Icons.arrow_back,
              onBackClick: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: ListView(
                children: List.generate(
                  20,
                  (index) => TapEffect(
                    onClick: () => Routes.push(TenantProfile(), context),
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
