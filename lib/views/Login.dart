import '/exports/exports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Body(
        child: Column(
          children: [
          SizedBox(height: MediaQuery.of(context).size.height /3),

            const Center(
              child: Text('Login'),
            ),
            
            ElevatedButton(onPressed: (){}, child: const Text("Get Started"))
          ],
        ),
      ),
    );
  }
}
