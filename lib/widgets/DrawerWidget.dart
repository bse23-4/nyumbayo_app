import 'dart:io';

import 'package:nyumbayo_app/controllers/LandlordController.dart';

import '../exports/exports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final credential = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userName = "John Doe";
  @override
  void initState() {
    firestore
        .collection("landlords")
        .doc(credential.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userName = value.data()?['name'] ?? "John Doe";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserdataController>().getUserData();
    context.read<LandlordController>().retrieveLandLordData();
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<LandlordController, Map<String, dynamic>>(
              builder: (context, data) {
            return UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.memory(base64.decode(data['profile'])))
                  // child: Text(
                  //   "${s?['name'].split(" ")[0].characters.first}${userName.split(" ")[1].characters.first}",
                  //   style: const TextStyle(
                  //       fontSize: 25, fontWeight: FontWeight.w700),
                  // ),
                  ),
              accountName: Text(userName),
              accountEmail: Text("${credential.currentUser?.email}"),
            );
          }),
          ListTile(
            title: const Text("Dashboard"),
            leading: const Icon(Icons.dashboard_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.dashboard);
            },
          ),
          const Divider(),
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
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.settings);
            },
          ),
          const Divider(),
          ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout_outlined),
              onTap: () {
                Navigator.pop(context);
                showProgress(context, text: "Logging out...");
                Auth.signOut().then((value) {
                  showMessage(
                      context: context,
                      msg: "Logged out successfully",
                      type: 'success');
                  Routes.routeUntil(context, Routes.login);
                });
              }),
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
