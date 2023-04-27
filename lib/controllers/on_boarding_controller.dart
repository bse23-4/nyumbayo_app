import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:nyumbayo_app/constants/text_strings.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../customWidgets/on_boarding_page_widget.dart';
import '../models/on_boarding_model.dart';

// ignore: camel_case_types
class onBoardingController extends GetxController{
  final controller = LiquidController();

  RxInt currentPage = 0.obs;

    final pages =[
       OnBoardingPageWidget(
        model: OnBoardingModel(
          image: tOnBoardingScreenImage1,
          title: tOnBoardingTitle1,
          counterText: tOnBoardingCounter1,
          subTitle: tOnBoardingSubTitle1,
          bgcolor: tOnBoardingPage1Color,
          //height: size.height,
        ),
      ),

       OnBoardingPageWidget(
        model: OnBoardingModel(
          image: tOnBoardingScreenImage2,
          title: tOnBoardingTitle1,
          counterText: tOnBoardingCounter2,
          subTitle: tOnBoardingSubTitle2,
          bgcolor: tOnBoardingPage2Color,
         // height: size.height,
        ),
      ),

       OnBoardingPageWidget(
        model: OnBoardingModel(
          image: tOnBoardingScreenImage3,
          title: tOnBoardingTitle3,
          counterText: tOnBoardingCounter3,
          subTitle: tOnBoardingSubTitle3,
          bgcolor: tOnBoardingPage3Color,
          //height: size.height,
        ),
      ),
    ];


  onPageChangedCallback(int activePageIndex)=>currentPage.value = activePageIndex;
  skip()=> controller.jumpToPage(page: 2);
  animateToNextSlide(){
     int nextPage = controller.currentPage + 1;
     controller.animateToPage(page: nextPage);
  }
  }

