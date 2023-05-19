import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:line_awesome_icons/line_awesome_icons.dart';
//import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:nyumbayo_app/constants/colors.dart';
import 'package:nyumbayo_app/constants/image.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/views/profile/profile_menu.dart';
import 'package:nyumbayo_app/views/profile/update_profile.dart';

import '../../constants/text_strings.dart';
//import '../Auth/forgot_password/forgot_password_btn_widget.dart';

class ProfileScreen extends StatelessWidget{
   const ProfileScreen({Key? key}) : super (key : key);

   @override
   Widget build(BuildContext context){
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
   return  Scaffold(
    appBar: AppBar( 
      leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_left)),
      title: Text(tProfile, style: Theme.of(context).textTheme.headlineSmall),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(isDark? Icons.light_mode :Icons.dark_mode)),
      ],
    ),
     body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 120, height: 120,
                  child: ClipRRect(borderRadius: BorderRadius.circular(100),child:const Image(image: AssetImage(tProfileImage))),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width:35,
                    height:35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: tPrimaryColor,
                    ),
                    child: const Icon(Icons.edit, color: Colors.black, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(tProfileHeading, style: Theme.of(context).textTheme.headlineSmall),
            Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Get.to(()=> const UpdateProfileScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tPrimaryColor, side: BorderSide.none, shape: const StadiumBorder(),
                ),
                child: const Text(tEditProfile, style:TextStyle(color: tDarkColor)),
                ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(title: tMenu1, icon: Icons.person, onPress:(){},endIcon: true,),
            ProfileMenuWidget(title: tMenu2, icon: Icons.wallet, onPress:(){},endIcon: true,),
            ProfileMenuWidget(title: tMenu3, icon: Icons.credit_card, onPress:(){},endIcon: true,),
            const Divider(),
            const SizedBox(height: 30),
            ProfileMenuWidget(
              title: "logout", 
              icon: Icons.logout, 
              textColor: Colors.red,
              endIcon: false,
              onPress: (){},
              ),
        
          ],
        ),
      ),
     ),
   );

   }
}


// child: const Icon(LineAwesomeIcons.user, color: tAccentColor, size: 20),