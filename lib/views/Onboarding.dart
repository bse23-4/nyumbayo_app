import '/exports/exports.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
 @override
  initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Routes.routeUntil(context,Routes.login);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset("assets/6184498.avif"),
                ),
                const Space(space: 0.05),
                SpinKitDualRing(color: Theme.of(context).primaryColor),
                const Space(space: 0.05),
                const Text(
                  "Loading...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        );
        //: const Login();
      },
    );
  }
}
