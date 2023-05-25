// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';

import 'Observers/IntervalObserver.dart';
import 'firebase_options.dart';
import 'exports/exports.dart';
import 'package:firebase_core/firebase_core.dart';
@pragma('vm:entry-point')
void firebaseMessagingBackgroundHandler(RemoteMessage message) {
  // If you're going to use other Firebase services in the background, such as Firestore,

}
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('android12splash');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    if (kDebugMode) {
      print(payload);
    }
  });
 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   // firebase messaging
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onMessage.listen((event) {
    if (kDebugMode) {
      print(event);
    }
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print('fcmToken: $fcmToken');
  }
  FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) {
      // TODO: If necessary send token to application server.
      if (kDebugMode) {
        print('fcmToken update: $fcmToken');
      }
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
    .onError((err) {
      // Error getting token.
      if (kDebugMode) {
        print(err.toString());
      }
    });
  // end of firebase messaging
  
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
