// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  EdgeInsets padding =
      const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 2);
  //
  bool _showpass = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.c,
            children: [
              const Space(space: 0.07),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text("Login",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 30)),
              ),
              AspectRatio(
                aspectRatio: 1.6,
                child: Image.asset("assets/6184498.png"),// SvgPicture.asset('assets/')
              ),

              CommonTextField(
                titleText: "Email",
                hintText: "example@gmail.com",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                padding: padding,
                enableBorder: true,
                controller: emailController,
              ),
              
              CommonTextField(
                titleText: "Password",
                padding: padding,
                hintText: "***********",
                icon: Icons.lock,
                controller: passwordController,
                keyboardType: TextInputType.text,
                enableSuffix: true,
                enableBorder: true,
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
              const Space(
                space: 0.03,
              ),
              CommonButton(
                backgroundColor:Colors.blue,
                padding: padding,
                height: 50,
                buttonText: "Login",
                onTap: () {
                  showProgress(context, text: "Logging in please wait...");
                  if (emailController.text.isEmpty &&
                      passwordController.text.isEmpty) {
                    Routes.pop(context);
                    showMessage(
                        context: context,
                        msg: "Please fill all fields",
                        type: 'danger');
                  } else if (emailController.text.isNotEmpty &&
                      passwordController.text.isEmpty) {
                    Routes.pop(context);
                    showMessage(
                        context: context,
                        msg: "Password is required",
                        type: 'danger');
                  } else if (passwordController.text.isNotEmpty &&
                      emailController.text.isEmpty) {
                    Routes.pop(context);
                    showMessage(
                        context: context,
                        msg: "Email is required",
                        type: 'danger');
                  } else if (passwordController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    Auth.signinLandlord(emailController.text,
                            passwordController.text, context)
                        .then((value) {
                      Routes.pop(context);
                      Routes.routeUntil(context, Routes.dashboard);
                      BlocProvider.of<UserdataController>(context)
                          .captureData();
                    }).whenComplete(() {
                      showMessage(
                        context: context,
                        msg: "Logged in Successfully",
                        type: 'success',
                      );
                    });
                  }
                },
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  children: [
                    Text("Don't have account",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black)),
                    TextButton(
                      onPressed: () {
                        Routes.routeUntil(context, Routes.signup);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
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
