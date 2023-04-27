
import 'package:flutter/material.dart';
import 'package:nyumbayo_app/constants/image.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/constants/text_strings.dart';
import 'package:nyumbayo_app/customWidgets/form/form_header_widget.dart';
import 'package:nyumbayo_app/views/Auth/signup/sign_up_form_widget.dart';

void main() => runApp(const  SignUp());

class  SignUp extends StatelessWidget {
  const  SignUp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children:  [
                const FormHeaderWidget(
                    title: tSignUpTitle,
                    image: tWelcomeScreenImage, 
                    subTitle: tOnBoardingSubTitle1 ,
                ),
               const SignUpFormWidget(),
               Column(
                children: [
                  const Text("OR"),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: (){}, 
                      icon: const Image(image: AssetImage(tGoogleImage), width: 20.0), 
                      label:Text(tSignInWithGoogle.toUpperCase()),
                      ),
                  ),
                  TextButton(
                    onPressed: (){}, 
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text:tAlreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyLarge),
                          TextSpan(text: tLogin.toUpperCase()),
                        ],
                      ),
                    ),
                    ),
                ],
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



                      