  import 'package:flutter/material.dart';
import 'package:nyumbayo_app/constants/sizes.dart';
import 'login_footer_widget.dart';
import 'login_form_widget.dart';
import 'login_header_widget.dart';

class Login extends StatelessWidget{
  const Login ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginHeaderWidget(size: size),
                  const LoginForm(),
                  const LoginFooterWidget(),
                ],
              ),
              
            ),

      ),
      ),
    );
  }
}

 



