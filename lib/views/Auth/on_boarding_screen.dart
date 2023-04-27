import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:nyumbayo_app/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controllers/on_boarding_controller.dart';



class  OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
   
   final obController =  onBoardingController();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:[
          LiquidSwipe(
            liquidController: obController.controller,
            onPageChangeCallback: obController.onPageChangedCallback,
            pages: obController.pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () => obController.animateToNextSlide(),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20.0),
              ), 
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(color: tDarkColor, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_ios)
                ),
              ),
            ),
          Positioned(
              top: 50,
              right:20,
              child: TextButton(
                onPressed: () => obController.skip(),
                child: const Text('Skip',style: TextStyle(color: Colors.grey)
                ),
              ),
              ),
          Obx( () => Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: obController.currentPage.value,
              count: 3,
              effect: const WormEffect(
                activeDotColor: Color.fromARGB(255, 189, 9, 212),
                dotHeight: 5.0,
                ),
              ),
            ),
            ), 
        ],
      ), 
    );
  }

}

