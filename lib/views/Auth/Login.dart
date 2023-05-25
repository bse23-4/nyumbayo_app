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
  final formKey = GlobalKey<FormState>();
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
              Row(
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
                  if (formKey.currentState!.validate()) {
                    showProgress(context, text: "Logging in please wait...");
                    Auth.signInTenant(
                            emailController.text, passwordController.text)
                        .then((value) {
                      BlocProvider.of<UserdataController>(context)
                          .captureData();
                      Routes.pop(context);
                      Routes.routeUntil(context, Routes.dashboard);
                    }).whenComplete(() {
                      BlocProvider.of<UserdataController>(context)
                          .captureData();
                      showMessage(
                          context: context, msg: "Logged in Successfully");
                    });
                  } else {
                    showMessage(
                        context: context, msg: "Please fill all the fields",type: 'danger'
                    );
                  }
                },
              ),
              const Space(space: 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
