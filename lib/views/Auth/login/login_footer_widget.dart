  import 'package:flutter/material.dart';

import '../../../constants/image.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

  class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('OR'),
        const SizedBox(height: tFormHeight - 20,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(tGoogleImage), width: 20.0,),
            onPressed: (){},
            label: const Text(tSignInWithGoogle ),
            ),
        ),
        const SizedBox(height: tFormHeight - 20,),
        TextButton(
          onPressed: (){}, 
          child:  Text.rich(
            TextSpan(
              text:tAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
              children: const[
                TextSpan(
                  text: tsignup,
                  style:TextStyle(color: Colors.blue),
                ),
              ]
              ),
              ),
            ),
      ],
    );
  }
}