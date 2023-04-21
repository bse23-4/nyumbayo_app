import '/exports/exports.dart';

class Routes {
  static String login = "/login";
  static String dashboard = "/dashboard";

  static Map<String, Widget Function(BuildContext)> routes(BuildContext context){
    return {
      "/login": (context) => const Login(),
      "/dashboard": (context) => const Dashboard(),
    };
  }
}