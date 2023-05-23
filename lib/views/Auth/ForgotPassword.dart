// ignore_for_file: use_key_in_widget_constructors

import 'package:nyumbayo_app/backend/auth.dart';

import '../../tools/index.dart';
import '../../widgets/Validator.dart';
import '/exports/exports.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with TickerProviderStateMixin {
  AnimationController? forgotController;
  String _errorEmail = '';
  TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    forgotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      value: 0,
    );
    forgotController!.forward();
  }
EdgeInsets pad = const EdgeInsets.only(
                        left: 24, right: 24, bottom: 24);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      
        child: BottomTopMoveAnimationView(
          animationController: forgotController!,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appBar(),
                Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 10.0, left: 24, right: 24),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Provide an email address that was registered at the time of creating your account.",
                              textAlign: TextAlign.start,
                              style: TextStyles(context)
                                  .getDescriptionStyle()
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ...[
                Space(space: 0.03,),
                  CommonTextField(
                    fieldColor: Theme.of(context).cardColor,
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    titleText:
                        "Email address", //AppLocalizations(context).of("your_mail"),
                    errorText: _errorEmail,
                    isObscureText: false,
                    padding: pad,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String txt) {},
                  ),
                  CommonButton(
                    padding: pad,
                    buttonText:
                        "Send Email Request",
                    onTap: () {
                      if (_allValidation()){
                        showProgress(context, text:"Sending email request",);
                       Auth.resetPassword(email: _emailController.text.trim()).then((value) {
                        Routes.pop(context);
                         if(AuthStatus.values.contains(value)){
                           showMessage(context:context, msg: "Email sent successfully",type: 'success');
                         }else{
                           showMessage(context:context, msg: "Email not sent",type: 'danger');
                           
                         }
                      });
                    }
                    }
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText:
          "Password Reset",
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  bool _allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail =
          "Email can't be empty"; //AppLocalizations(context).of('email_cannot_empty');
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail =
          "Provide a valid email"; //AppLocalizations(context).of('enter_valid_email');
      isValid = false;
    }
    setState(() {});
    return isValid;
  }
}
