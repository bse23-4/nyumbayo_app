

import '/exports/exports.dart';

class Routes {
  static String login = "/login";
  static String signup = "/register";
  static String dashboard = "/dashboard";
  static String addProperty = "/add-property";
  static String addTenant = "/add-tenant";
  static String tenants = "/tenants";
  static String properties = "/properties";
  static String complaints = "/complaints";
  static String payment = "/payments";
  static String onboard = "/onboarding";
  static String stats = "/stats";

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
  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      Routes.login: (context) => const Login(),
      Routes.dashboard: (context) => const Dashboard(),
      Routes.addProperty: (context) => const AddProperty(),
      Routes.addTenant: (context) => const AddTenant(),
      Routes.complaints: (context) => const ViewReports(),
      Routes.tenants: (context) => const ViewTenants(),
      Routes.payment:(context) => const PaymentScreen(),
      Routes.onboard: (context) => const OnboardingScreen(),
      Routes.signup: (context) => const SignUp(),
      Routes.stats: (context) => const Stats(),
    };
  }
}
