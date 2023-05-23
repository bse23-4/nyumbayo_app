import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyumbayo_app/constants/colors.dart';
import 'package:nyumbayo_app/constants/image.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/tools/index.dart';
import 'package:nyumbayo_app/views/profile/profile_menu.dart';
import 'package:nyumbayo_app/views/profile/update_profile.dart';

import '../../backend/auth.dart';
import '../../constants/text_strings.dart';
import '../../exports/exports.dart';
//import '../Auth/forgot_password/forgot_password_btn_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
                    child: Text("${context.read<TenantController>().state['name'].split(" ")[0].toString().characters.first.toUpperCase()}${context.read<TenantController>().state['name'].split(" ")[1].toString().characters.first.toUpperCase()}",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(context.read<TenantController>().state['name'],
                  style: Theme.of(context).textTheme.headlineSmall),
              Text(context.read<TenantController>().state['email'],
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: tMenu1,
                icon: Icons.person,
                onPress: () {},
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: tMenu2,
                icon: Icons.wallet,
                onPress: () {},
                endIcon: true,
              ),
              ProfileMenuWidget(
                title: tMenu3,
                icon: Icons.credit_card,
                onPress: () {},
                endIcon: true,
              ),
              const Divider(),
              const SizedBox(height: 30),
              ProfileMenuWidget(
                title: "logout",
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  showProgress(context, text: "Logging out...");
                  Auth.signOut().then((value) {
                    Routes.pop(context);
                  }).whenComplete(() {
                    Routes.routeUntil(context, Routes.login);
                    showMessage(
                        context: context,
                        msg: "Logged out successfully",
                        type: 'success');
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// child: const Icon(LineAwesomeIcons.user, color: tAccentColor, size: 20),