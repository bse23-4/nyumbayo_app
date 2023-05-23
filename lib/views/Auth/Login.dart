// ignore_for_file: deprecated_member_use

import '../../backend/auth.dart';
import '../../tools/index.dart';
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
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 50,
                      color: Colors.black,
                      fontWeight: FontWeight.w200),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.6,
                child: Image.asset("assets/images/house.png"),
              ),
              CommonTextField(
                titleText: "Email",
                hintText: "example@gmail.com",
                icon: Icons.email,
                padding: padding,
                controller: emailController,
              ),
            
              Padding(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    TextButton(
                      onPressed: () {
                        Routes.named(context, Routes.forgotPassword);
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),
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
                  // FutureBuilder(
                  //   future: Auth.signInTenant(
                  //     emailController.text,
                  //     passwordController.text,
                  //   ),
                  //   builder: (context, snap) {
                  //     if (snap.connectionState == ConnectionState.waiting) {
                  //       showProgress(context,
                  //           text: "Logging in please wait...");
                  //     } else if (snap.connectionState == ConnectionState.done) {
                  //       if (snap.hasError) {
                  //         return Center(child: Text("Error ${snap.error}}"));
                  //       } else if (snap.hasData) {
                  //         BlocProvider.of<UserdataController>(context).captureData();
                  //         Routes.pop(context);
                  //         Routes.routeUntil(context, Routes.dashboard);
                  //         showMessage(
                  //             context: context, msg: "Logged in Successfully");
                  //       }
                  //     }
                  //     return const Center(child: Text("No Data"));
                  //   },
                  // );
                  showProgress(context, text: "Logging in please wait...");
                  Auth.signInTenant(
                          emailController.text, passwordController.text)
                      .then((value) {
                    BlocProvider.of<UserdataController>(context).captureData();
                    Routes.pop(context);
                    Routes.routeUntil(context, Routes.dashboard);
                  }).whenComplete(() {
                    BlocProvider.of<UserdataController>(context).captureData();
                    showMessage(
                        context: context, msg: "Logged in Successfully");
                  });
                },
              ),
              const Space(space: 0.03),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20),
              //   child: Row(
              //     children: [
              //       const Text(
              //         "Don't have account",
              //         style:
              //             TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              //       ),
              //       TextButton(
              //         onPressed: () {
              //           Routes.routeUntil(context, Routes.signup);
              //         },
              //         child: const Text(
              //           "Sign Up",
              //           style: TextStyle(
              //               fontSize: 18, fontWeight: FontWeight.w500),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
