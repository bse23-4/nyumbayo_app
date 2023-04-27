import 'package:flutter/material.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/constants/text_strings.dart';


class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.symmetric(vertical: tFormHeight-10),
         child: Form(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               TextFormField(
                 decoration: const InputDecoration(
                   label: Text(tFullName),
                   prefixIcon: Icon(Icons.person_2_outlined),
                 ),
               ),
               const SizedBox(height: tFormHeight-20,),
               TextFormField(
                 decoration: const InputDecoration(
                   label: Text(tEmail),
                   prefixIcon: Icon(Icons.email_rounded),
                 ),
               ),
               const SizedBox(height: tFormHeight-20),
               TextFormField(
                 decoration: const InputDecoration(
                   label: Text(tContact),
                   prefixIcon: Icon(Icons.numbers),
                 ),
               ),
               const SizedBox(height: tFormHeight-20),
               TextFormField(
                 decoration: const InputDecoration(
                   label: Text(tAddress),
                   prefixIcon: Icon(Icons.person_outline_sharp),
                 ),
               ),
               const SizedBox(height: tFormHeight-20),
               TextFormField(
                 decoration: const InputDecoration(
                   label: Text(tPassword ),
                   prefixIcon: Icon(Icons.fingerprint_outlined),
                 ),
               ),
               const SizedBox(height: tFormHeight-20),
               TextFormField(
                 decoration: const InputDecoration(
                   label: Text(tConfirmPassword ),
                   prefixIcon: Icon(Icons.fingerprint_sharp),
                 ),
               ),
               const SizedBox(height: tFormHeight-20),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: (){}, 
                   child:  Text(tsignup.toUpperCase()),
                 ),
               ),
             ],
           ),
         ),
     );
  }
}
