import 'dart:io';

import '../exports/exports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person_3),
            ),
            accountName: Text("Admin"),
            accountEmail: Text("admin@gmail.com"),
          ),
           ListTile(
            title: const Text("Add Property"),
            leading: const Icon(Icons.add_home_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.addProperty);
            },
          ),
          const Divider(),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout_outlined),
            onTap: () {
              Navigator.pop(context);
              
            }
          ),
          const Divider(),
          ListTile(
            title: const Text("Exit"),
            leading: const Icon(Icons.exit_to_app_outlined),
            onTap: () => exit(0),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
