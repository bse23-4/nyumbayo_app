import 'dart:io';

import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/views/profile/profile_menu.dart';

import '/backend/auth.dart';
import '/constants/text_strings.dart';
import '/exports/exports.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    radius: 50,
                    child: Text(
                        "${context.read<TenantController>().state['name'].split(" ")[0].toString().characters.first.toUpperCase()}${context.read<TenantController>().state['name'].split(" ")[1].toString().characters.first.toUpperCase()}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(context.read<TenantController>().state['name'],
                  style: TextStyles(context).getTitleStyle()),
              Text(context.read<TenantController>().state['email'],
                  style: TextStyles(context).getRegularStyle()),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: context.read<TenantController>().state['contact'],
                icon: Icons.phone,
                onPress: () {},
                endIcon: false,
              ),
              ProfileMenuWidget(
                title: context.read<TenantController>().state['address'],
                icon: Icons.location_on,
                onPress: () {},
                endIcon: false,
              ),
            
              ProfileMenuWidget(
                title: "logout",
                icon: Icons.logout,
                endIcon: false,
                onPress: () {
                  showProgress(context, text: "Logging out...");
                  Auth.signOut().then((value) {
                  }).whenComplete(() {
                    Routes.routeUntil(context, Routes.login);
                    showMessage(
                        context: context,
                        msg: "Logged out successfully",
                        type: 'success');
                  });
                },
              ),
                ProfileMenuWidget(
                title: "Exit",
                icon: Icons.exit_to_app,
                onPress: () => exit(0),
                endIcon: false,
              ),
             Space(space: 0.03),
             Divider()
            ],
          ),
        ),
      ),
    );
  }
}


// child: const Icon(LineAwesomeIcons.user, color: tAccentColor, size: 20),