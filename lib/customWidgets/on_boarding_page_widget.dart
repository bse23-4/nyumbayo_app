import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../models/on_boarding_model.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: model.bgcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(
            image: AssetImage(model.image),
            height: (size.height) * 0.5,
          ),
          Column(
            children: [
              Text(model.title,style: Theme.of(context).textTheme.headlineMedium,),
              Text(model.subTitle,textAlign: TextAlign.center,),
            ],
          ),
          Text(model.counterText),
          const SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}