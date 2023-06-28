// ignore_for_file: deprecated_member_use

import '../../backend/auth.dart';
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
  String _msg = "";
  String _pw_msg = "";
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
                enableBorder: true,
                titleText: "Email",
                hintText: "example@gmail.com",
                icon: Icons.email,
                validate: (x) {
                  setState(() {
                    if (x!.isEmpty) {
                      _msg = "Email is required";
                    } else if (!x.contains("@")) {
                      _msg = "Invalid Email";
                    }
                  });
                  return null;
                },
                padding: padding,
                controller: emailController,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  _msg,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              CommonTextField(
                enableBorder: true,
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
                validate: (x) {
                  setState(() {
                    if (x!.isEmpty) {
                      _pw_msg = "Password is required";
                    } else if (x.length < 6) {
                      _pw_msg = "Password must be at least 6 characters";
                    }
                  });
                  return null;
                },
                onTapSuffix: () {
                  setState(() {
                    _showpass = !_showpass;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  _pw_msg,
                  style: const TextStyle(color: Colors.red),
                ),
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
              CommonButton(
                padding: padding,
                height: 50,
                buttonText: "Login",
                onTap: () {
                  // check if all fields are detailed with data
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      !formKey.currentState!.validate()) {
                    showMessage(
                        context: context,
                        msg: "Please fill all the fields",
                        type: 'danger');
                  } else {
                    showProgress(context, text: "Logging in please wait...");
                    Auth.login(emailController.text, passwordController.text)
                        .then((value) {
                          Routes.pop(context);
                      if (FirebaseAuth
                              .instance.currentUser!.emailVerified ==
                          false) {
                        Routes.named(context, Routes.verify);
                      } else {
                        BlocProvider.of<UserdataController>(context)
                            .captureData();
                        Routes.pop(context);
                        Routes.routeUntil(context, Routes.dashboard);
                          showMessage(
                          context: context, msg: "Logged in Successfully");
                      }
                    }).whenComplete(() {
                      BlocProvider.of<UserdataController>(context)
                          .captureData();
                    
                    });
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
