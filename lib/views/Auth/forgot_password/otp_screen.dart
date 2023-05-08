import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/constants/text_strings.dart';
// import 'package:nyumbayo_app/constants/sizes.dart';

// import '../../../constants/image.dart';
// import '../../../constants/text_strings.dart';
// import '../../../customWidgets/form/form_header_widget.dart';
class OTPScreen extends StatelessWidget{
  const OTPScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tOtpTitle, style: GoogleFonts.montserrat(
              fontWeight:  FontWeight.bold,
              fontSize: 60.0
            ),),
            Text(tOtpSubTitle.toUpperCase(), style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 40.0),
            const Text("$tOtpMessage mulikateteangella@gmail.com", textAlign: TextAlign.center,),
            const SizedBox(height:20.0),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.2),
              filled: true,
            ),
            const SizedBox(height: 20.0,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){}, child: const Text(tNext),
              ),
            ),
          ],
        ),
      ),
    );
  }
}