import '/exports/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    BlocProvider.of<UserdataController>(context).captureData();
     BlocProvider.of<UserdataController>(context).getUserData();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      BlocProvider.of<UserdataController>(context).getUserData();
      InternetConnectionChecker.createInstance().hasConnection.then((value) {
        if (value == false) {
          Routes.routeUntil(context, Routes.offline);
        } else {
          if (FirebaseAuth.instance.currentUser?.emailVerified == false ||
              FirebaseAuth.instance.currentUser == null) {
            Routes.routeUntil(context, Routes.login);
          } else {
            if (context.read<TenantController>().state.isEmpty &&
                context.read<UserdataController>().state.isEmpty) {
              Routes.routeUntil(context, Routes.login);
            } else {
              Routes.routeUntil(context, Routes.dashboard);
            }
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
 BlocProvider.of<UserdataController>(context).captureData();
 BlocProvider.of<UserdataController>(context).getUserData();
 if (BlocProvider.of<UserdataController>(context).state.isNotEmpty) {
     BlocProvider.of<TenantController>(context).fetchTenants(context.read<UserdataController>().state);
 }

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
                Text(
                  FirebaseAuth.instance.currentUser == null
                      ? "Loading user authentication"
                      : "Loading user session",
                  style: const TextStyle(
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
