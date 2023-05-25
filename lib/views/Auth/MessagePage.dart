import 'package:flutter/material.dart';
import 'package:nyumbayo_app/exports/exports.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, value: 0, duration: const Duration(seconds: 3));
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
              aspectRatio: 1.7,
              child: SvgPicture.asset("assets/images/email_verify.svg")),
          Text(
            "Check you mail box to reset your password",
            style: TextStyles(context).getRegularStyle(),
          ),
          const Space(space: 0.05),
          CommonButton(
            buttonText: "Back to Login",
            padding: EdgeInsets.all(20),
            height: 55,
            onTap: () => Routes.routeUntil(context, Routes.login),
          ),
        ],
      ),
    );
  }
}
