// ignore_for_file: depend_on_referenced_packages

import 'Observers/IntervalObserver.dart';
import 'firebase_options.dart';
import 'exports/exports.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const Observer();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserdataController()),
          BlocProvider(create: (_) => AmountController()),
          BlocProvider(create: (_) => TenantController()),
          BlocProvider(create: (_) => PowerStatusController()),
          ChangeNotifierProvider(create: (_) => MainController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          routes: Routes.routes,
        ),
      ),
    );
} 
