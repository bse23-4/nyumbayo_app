  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import 'forgot_password_btn_widget.dart';
import 'forgot_password_mail.dart';

class ForgetPasswordScreen{
    static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
                context: context, 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                builder: (context)=> Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tForgotPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,),
                      Text(tForgotEmailSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
                      const SizedBox(height: 30.0),
                      ForgotPasswordBtnWidget(
                        btnIcon: Icons.mail_outline_rounded,
                        title: tEmail,
                        subtitle: tResetViaEmail,
                        onTap: (){
                          Navigator.pop(context);
                          Get.to(()=>const ForgotPasswordMailScreen ());
                        },
                      ),
                       const SizedBox(height: 20.0,),
                       ForgotPasswordBtnWidget(
                        btnIcon: Icons.mobile_friendly_rounded,
                        title: tContact,
                        subtitle: tResetViaPhone,
                        onTap: (){},
                      ),
                      const SizedBox(height: 20.0,),
                    ],
                  ),
                ),
              );
  }
}
 

