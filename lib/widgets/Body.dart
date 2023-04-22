import '/exports/exports.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.blue.shade500,
                // shape: BoxShape.circle,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                ),
              ),
            )),
        child
      ],
    );
  }
}
