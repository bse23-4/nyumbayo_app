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
                child: Image.asset("assets/6184498.png"),
              ),
              CommonTextField(
                titleText: "Email",
                hintText: "example@gmail.com",
                icon: Icons.email,
                padding: padding,
                controller: emailController,
              ),
              CommonTextField(
                titleText: "Password",
                padding: padding,
                hintText: "***********",
                icon: Icons.lock,
                controller: passwordController,
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
              const Space(
                space: 0.03,
              ),
              CommonButton(
                padding: padding,
                height: 50,
                buttonText: "Login",
                onTap: () {
                  showProgress(context,text: "Logging in please wait...");
                  BlocProvider.of<UserdataController>(context).captureData();
                  Auth.signinLandlord(emailController.text, passwordController.text).then((value) {
                    Routes.pop(context);
                    Routes.routeUntil(context, Routes.dashboard);
                  }).whenComplete(() {
                    showMessage(context: context,msg: "Logged in Successfully");
                  });
                },
              ),
              const Space(space: 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  children: [
                    Text("Don't have account",
                        style: Theme.of(context).textTheme.bodyText1),
                    TextButton(
                      onPressed: () {
                        Routes.routeUntil(context, Routes.signup);
                      },
                      child: const Text("Sign Up"),
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
