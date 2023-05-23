// ignore_for_file: file_names, library_private_types_in_public_api

import '/exports/exports.dart';

class Loader extends StatefulWidget {
  final double size;
  final String? text;
  const Loader({super.key, this.size = 30, this.text = ''});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  double sides = 60;

  Animation<double>? animation;
  AnimationController? controller;
  Animation<double>? animationPulse;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 40),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

// tween animations
    Tween<double> radiusTween = Tween(begin: 0, end: 200);
// end of  tween animations

// curves animation implementing pulse
    animationPulse = CurveTween(curve: Curves.easeInOut).animate(controller!);

    animation = radiusTween.animate(controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller?.forward();
        }
      });

    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitDualRing(color: Theme.of(context).primaryColor),
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text(
            "Loading ${widget.text}..",
            style: TextStyles(context).getRegularStyle(),
          ),
        )
      ],
    );
  }
}
