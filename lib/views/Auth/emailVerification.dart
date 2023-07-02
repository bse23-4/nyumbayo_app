// ignore_for_file: use_build_context_synchronously


import '../../exports/exports.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Routes.named(context, Routes.login);
      // TODO: implement your code after email verification
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Successfully Verified"),
        ),
      );

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Check your Email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(width: 200,height: 200,child:  SvgPicture.asset("assets/email_verify.svg"),),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
              child: Text(
                'We have sent you an Email on  ${FirebaseAuth.instance.currentUser?.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
              child: Text(
                'Verifying email....',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(height: 57),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              child: const Text('Resend'),
              onPressed: () {
                try {
                  FirebaseAuth.instance.currentUser
                      ?.sendEmailVerification().then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Email Verification resent successfully.',
                        )
                      )
                    );
                      });
                } catch (e) {
                  debugPrint('$e');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
