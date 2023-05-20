import 'package:firebase_core/firebase_core.dart';

import '/exports/exports.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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

