import '/exports/exports.dart';
class Body extends StatelessWidget {
 final Widget child;

  const Body({Key? key, required this.child}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child: child, left: 0, top: 0, right: 0, bottom: 0),
        child
      ],
    );
  }
}