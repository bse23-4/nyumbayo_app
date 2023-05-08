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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.c,
          children: [
            const Space(space:0.07),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text("Login", style: Theme.of(context).textTheme.headline4!.copyWith(fontSize:30)),
            ),
            AspectRatio(
              aspectRatio: 1.6,
              child: Image.asset("assets/nyumbayo.png"),
            ),
            CommonTextField(
              hintText: "Email",
              icon: Icons.email,
              padding: padding,
            ),
            CommonTextField(
              padding: padding,
              hintText: "Password",
              icon: Icons.lock,
              enableSuffix: true,
              suffixIcon: _showpass == false? Icons.visibility_off_outlined : Icons.remove_red_eye,
              isObscureText: !_showpass,
              onTapSuffix: (){
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
