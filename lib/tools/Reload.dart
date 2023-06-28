// ignore_for_file: must_be_immutable

import '/exports/exports.dart';

class ReloadApp extends StatefulWidget {
  Widget? child;
  ReloadApp({Key? key, this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_ReloadAppState>()?.restartApp();
  }

  @override
  State<StatefulWidget> createState() {
    return _ReloadAppState();
  }
}

class _ReloadAppState extends State<ReloadApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child ?? Container(),
    );
  }
}