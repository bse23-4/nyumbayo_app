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
    _controller = AnimationController(vsync: this,value:0,duration: const Duration(milliseconds: 900));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomTopMoveAnimationView(
          animationController: _controller,
          child: Column(
            children: [
              CommonAppbarView(titleText: "Tenants",)
            ],
          )),
    );
  }
}
