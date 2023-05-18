// ignore_for_file: deprecated_member_use

import 'package:nyumbayo_app/models/User.dart';

import '/exports/exports.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  EdgeInsets padding =
      const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 2);
  //
  bool _showpass = false;
  bool _cshowpass = false;
  final formKey = GlobalKey<FormState>();
  // controllers
  final nameController =  TextEditingController();
  final emailController =  TextEditingController();
  final passwordController =  TextEditingController();
  final confirmPassController =  TextEditingController();
  final contactController =  TextEditingController();
  final addressController =  TextEditingController();
  // end of controllers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.c,
            children: [
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text("Sign up",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 30)),
              ),
              AspectRatio(
                aspectRatio: 2.5,
                child: Image.asset("assets/6184498.png"),
              ),
              CommonTextField(
                titleText: "Name",
                hintText: "John Doe",
                controller: nameController,
                icon: Icons.email,
                padding: padding,
              ),CommonTextField(
                titleText: "Email",
                hintText: "example@gmail.com",
                controller: emailController,
                icon: Icons.email,
                padding: padding,
              ), CommonTextField(
                titleText: "Contact",
                hintText: "075xxxx-xxxx-xxxx",
                controller: contactController,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                padding: padding,
              ),
              CommonTextField(
                titleText: "Password",
                padding: padding,
                controller: passwordController,
                hintText: "***********",
                icon: Icons.lock,
                enableSuffix: true,
                suffixIcon: _showpass == false
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye,
                isObscureText: !_showpass,
                onTapSuffix: () {
                  setState(() {
                    _showpass = !_showpass;
                  });
                },
              ),
               CommonTextField(
                titleText: "Confirm Password",
                padding: padding,
                controller: confirmPassController,
                hintText: "***********",
                icon: Icons.lock,
                enableSuffix: true,
                suffixIcon: _cshowpass == false
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye,
                isObscureText: !_cshowpass,
                onTapSuffix: () {
                  setState(() {
                    _cshowpass = !_cshowpass;
                  });
                },
              ),
              const Space(
                space: 0.03,
              ),
              CommonButton(
                padding: padding,
                height: 50,
                buttonText: "Login",
                onTap: () {
                  showProgress(context,text:"Creating landlord account in progress...");
                  if (formKey.currentState!.validate()) {
                   var user = Landlord(name: nameController.text, email: emailController.text, contact: contactController.text, address: addressController.text, password: passwordController.text);
                   Auth.createLandlord(user).then((value){
                        Routes.pop(context);
                        Routes.named(context, Routes.login);
                   }).whenComplete(() {
                    showMessage(context: context,msg: "Account created successfully",type: "success");
                   });
                  }
                },
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Row(
                  children: [
                    Text("Already have an account    |",
                        style: Theme.of(context).textTheme.bodyText1),
                    TextButton(
                      onPressed: () => Routes.routeUntil(context, Routes.login),
                      child: const Text("login"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
