import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:nyumbayo_app/constants/colors.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/constants/text_strings.dart';
// import 'package:nyumbayo_app/constants/colors.dart';
import 'package:nyumbayo_app/constants/image.dart';
import 'package:nyumbayo_app/views/profile/profile_screen.dart';
// import 'package:nyumbayo_app/constants/sizes.dart';

// import '../../constants/text_strings.dart';
//import '../Auth/forgot_password/forgot_password_btn_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_left)),
        title: Text(tEditProfile,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).primaryColor),
                      child: const Icon(
                        Icons.camera,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(tFullName),
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: tFormHeight - 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(tEmail),
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(tContact),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(tAddress),
                        prefixIcon: Icon(Icons.person_outline_sharp),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(tPassword),
                        prefixIcon: Icon(Icons.fingerprint_outlined),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const ProfileScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(tEditProfile,
                           ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
