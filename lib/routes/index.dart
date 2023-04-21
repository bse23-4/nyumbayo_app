import '/exports/exports.dart';

class Routes {
  static String login = "/login";
  static String dashboard = "/dashboard";
  static String addProperty = "/add-property";
  static String addTenant = "/add-tenant";
  static String tenants = "/tenants";
  static String properties = "/properties";
  static String complaints = "/complaints";
  
  static Map<String, Widget Function(BuildContext)> routes(BuildContext context){
    return {
      "/login": (context) => const Login(),
      "/dashboard": (context) => const Dashboard(),
      "/add-property": (context) => const AddProperty(),
      "/add-tenant": (context) => const AddTenant(),
      "/complaints":(context) => const ViewReports()
    };
  }
}