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
              CommonAppbarView(titleText: "",)
            ],
          )),
    );
  }
}
