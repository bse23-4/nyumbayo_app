import '/exports/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    Future.delayed(const Duration(seconds: 6)).then((value) {
      BlocProvider.of<UserdataController>(context).getUserData();
      if (context.read<UserdataController>().state == "") {
        Routes.routeUntil(context, Routes.login);
      } else {
        Routes.routeUntil(context, Routes.dashboard);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserdataController>(context).getUserData();
    return Builder(
      // future: Future.delayed(const Duration(seconds: 3)),
      builder: (context) {
        return // s.connectionState == ConnectionState.waiting
            Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.8,
                  child: Image.asset("assets/images/house.png"),
                ),
                const Space(space: 0.05),
                SpinKitDualRing(color: Theme.of(context).primaryColor),
                const Space(space: 0.05),
                const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
