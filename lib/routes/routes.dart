

import 'package:nyumbayo_app/views/Auth/splash_screen.dart';
import 'package:nyumbayo_app/views/complaint/complaint.dart';

import '../views/Auth/ForgotPassword.dart';
import '../views/Auth/MessagePage.dart';
import '/exports/exports.dart';

class Routes {
  static String login = "/login";
  static String signup = "/register";
  static String dashboard = "/dashboard";
  static String addProperty = "/add-property";
  static String addTenant = "/add-tenant";
  static String tenants = "/tenants";
  static String messagePage = "/msgPage";
  static String complaints = "/complaints";
  static String payment = "/payments";
  static String forgotPassword = "/forgotPassword";
  static String splash = "/splash";

  // route pages with widgets
  static void push(Widget widget, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
      ),
    );
  }
  // pop off widget
  static void pop(BuildContext context){
    Navigator.of(context).pop();
  }

  // route without return
  static void routeUntil(BuildContext context, String route){
    Navigator.of(context).pushReplacementNamed(route);
  }
  // named routes
  static void named(BuildContext context, String route){
    Navigator.of(context).pushNamed(route);
  }
  // routes
  static Map<String, Widget Function(BuildContext)> routes =
     {
      Routes.login: (context) => const Login(),
      Routes.dashboard: (context) => const Dashboard(),
      Routes.complaints: (context) => const Complaint(),
      Routes.splash:(context) => const SplashScreen(),
      Routes.forgotPassword: (context) => ForgotPassword(),
      Routes.messagePage: (context) => const MessagePage(),
  };
}
