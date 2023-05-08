import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:nyumbayo_app/constants/sizes.dart';

import '../../../constants/image.dart';
import '../../../constants/text_strings.dart';
import '../../../customWidgets/form/form_header_widget.dart';
import 'otp_screen.dart';

class ForgotPasswordMailScreen extends  StatelessWidget{
  const ForgotPasswordMailScreen({Key? key}): super(key: key);
    
    @override
    Widget build(BuildContext context){
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const SizedBox(height: tDefaultSize*4,),
                const FormHeaderWidget(
                  image: tForgotPasswordImage,
                  title: tForgotPassword ,
                  subTitle: tForgotPasswordSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: tFormHeight),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(tEmail),
                          hintText: tEmail,
                          prefixIcon: Icon(Icons.mail_lock_rounded),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){Get.to(()=> const OTPScreen());} ,
                          child: const Text(tNext)
                          ),
                      ),
                  
                    ],
                  ),
                ),
              ],
            ),
          ),
          ),
        ),
      );
    }
}