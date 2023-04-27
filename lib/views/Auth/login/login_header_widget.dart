  import 'package:flutter/material.dart';

import '../../../constants/image.dart';
import '../../../constants/text_strings.dart';

  class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: const AssetImage(tWelcomeScreenImage), height: size.height*0.5),
       // Text(tLoginTitle, style: Theme.of(context).textTheme.displayMedium),
        Text(tLoginSubTitle, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}