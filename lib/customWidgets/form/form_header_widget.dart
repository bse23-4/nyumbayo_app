  import 'package:flutter/material.dart';
  

  class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        Image(image: AssetImage(image), ),
        Text(subTitle, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}