import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:nyumbayo_app/constants/colors.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/views/Auth/signup/signup.dart';

import '../../constants/image.dart';
import '../../constants/text_strings.dart';
import 'login/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    // var brightness = mediaQuery.platformBrightness;
    // final isDarkMode  = brightness == Brightness.dark;
    return Scaffold(
      //backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Container( 
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          Column( 
            children:  [
                Text(tWelcomeTitle, style: Theme.of(context).textTheme.displaySmall,),
                Text(tWelcomeSubTitle, textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
           Image(image: const AssetImage(tWelcomeScreenImage), height: height * 0.5,),
          Row(
             children :  [
             Expanded(
              child:  OutlinedButton(
                onPressed: () => Get.to(()=> const Login()), 
                child: const Text(tLogin)
              ),
              ),
             const SizedBox(width:10.0),
             Expanded(
              child:  ElevatedButton(
                onPressed: () => Get.to(()=> const SignUp()),
                child: const Text(tsignup)
                ),
                ),
            ]
          ),
        ],
        ),
      ),
    );
  }
}