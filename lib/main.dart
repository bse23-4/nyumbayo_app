import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '/exports/exports.dart';
import 'Observers/IntervalObserver.dart';
import 'controllers/MainController.dart';
import 'firebase_options.dart';

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
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const Observer();
  runApp(
    MultiBlocProvider(
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
          create: (context) => AmountController(),
        ),
        BlocProvider(
          create: (context) => PropertyController(),
        ),
        BlocProvider(
          create: (context) => PropertyIdController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainController(),
        ),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: theme.copyWith(
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
  );
}
