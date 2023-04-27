  import 'package:flutter/material.dart';
  

  class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imageColor,
    this.heightBetween,
    this. imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
    required this.image,
    required this.subTitle,
    required this.title,
  });

  final String image, title, subTitle;
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        Image(image: AssetImage(image), color: imageColor,height: size.height*imageHeight),
        Text(subTitle, textAlign:textAlign, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: heightBetween,),
      ],
    );
  }
}