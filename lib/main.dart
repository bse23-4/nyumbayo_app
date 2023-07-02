import 'package:firebase_core/firebase_core.dart';
import 'package:nyumbayo_app/tools/index.dart';

import '/exports/exports.dart';
import 'Observers/IntervalObserver.dart';
import 'controllers/LandlordController.dart';
import 'controllers/TenantController.dart';
import 'firebase_options.dart';
import 'tools/Reload.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // system layout settings
  // portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // set status view
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      // statusBarIconBrightness: Brightness.light,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initialize app notifications
  initializeNotifications();
  // end of app notification initialization

  //
  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  Bloc.observer = const Observer();
  runApp(
    ReloadApp(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeController(),
          ),
          BlocProvider(
            create: (context) => PowerConnectionController(),
          ),
          BlocProvider(
            create: (context) => UserdataController(),
          ),
          BlocProvider(
            create: (context) => TenantController(),
          ),
          BlocProvider(
            create: (context) => LandlordController(),
          ),
          BlocProvider(
            create: (context) => AmountController(),
          ),
          BlocProvider(
            create: (context) => PropertyController(),
          ),
          BlocProvider(
            create: (context) => PropertyIdController(),
          ),
          BlocProvider(create: (context) => ComplaintsController()),
          ChangeNotifierProvider(
            create: (context) => MainController(),
          ),
        ],
        child: BlocBuilder<ThemeController, ThemeData>(
          builder: (context, theme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme.copyWith(
                appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 5, 70, 150)),
                useMaterial3: true,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(
                  bodyColor: theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  displayColor: theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              initialRoute: Routes.onboard,
              routes: Routes.routes(context),
            );
          },
        ),
      ),
    ),
  );
}
