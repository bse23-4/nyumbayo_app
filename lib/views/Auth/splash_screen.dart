import 'package:flutter/material.dart';
//import 'package:nyumbayo_app/views/Auth/welcome.dart';

import '../../constants/colors.dart';
import '../../constants/image.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import 'package:get/get.dart';

import '../../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
 final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
       body: Stack(
        children:  [
           Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            top: splashController.animate.value ? 0: -30,
            left: splashController.animate.value ? 0: -30,
            child:  const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Image(
                  image: AssetImage(tSplashScreenImageIcon),
                ),
              ),
            ),         
            ),
          ),
           
           Obx(() =>AnimatedPositioned(
             duration: const Duration(milliseconds: 1000),
             top: 80,
             left: splashController.animate.value ?tDefaultSize : -80,
             child: AnimatedOpacity(
              opacity: splashController.animate.value ? 1: 0, 
              duration: const Duration(milliseconds: 1000),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(tWelcomeTitle, style:Theme.of(context).textTheme.headlineMedium,  textAlign: TextAlign.center,),
                Text(tWelcomeSubTitle, style:Theme.of(context).textTheme.titleLarge,  textAlign: TextAlign.center,),
              ],
            ),
          ),
          ),
        ),
         Obx(() =>  AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            bottom: splashController.animate.value ?100 :0 ,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: splashController.animate.value ? 1: 0,
              child: const Image(image: AssetImage(tSplashScreenImage1 )),
             ),
           ),
          ),
         Obx(() =>  AnimatedPositioned(
            duration: const Duration(milliseconds: 2400),
            bottom: splashController.animate.value ? 60: 0,
            right: tDefaultSize,
            child: AnimatedOpacity(duration: const Duration(milliseconds: 2000), opacity: splashController.animate.value ? 1: 0,
              child: Container(
                width:tSplashContainerSize,
                height: tSplashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color:tPrimaryColor,
                ),
              ) ,
            ),
          ),
        )
        ],
       ),
    );
  }
}
