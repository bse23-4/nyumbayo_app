import 'package:nyumbayo_app/exports/exports.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  int _currentStep = 0;
  final rentController = TextEditingController();
  final electricController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String errorText1 = '';
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //stream error
  StepState assignState({required int index}) {
    if (_currentStep == index) {
      return StepState.editing;
    } else if (_currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }
  bool step1 = true;
  bool step2 = false;
  bool step3 = false;
  int mtn = 0;
  int airtel = 0;
  int _index = 0;
  final _amountPayKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonAppbarView(
              titleText: "Payment Process",
              titlePadding: const EdgeInsets.all(20),
              iconData: Icons.arrow_back_ios,
              onBackClick: () => Routes.pop(context),
              topPadding: 20,
            ),
            Stepper(
              currentStep: _currentStep,
              onStepCancel: step3 == true ? null : () {
                setState(() {
                  _index = 0;
                  _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
                });
              },
              onStepContinue: step3 == true ? null : () {
                setState(() {
                  _currentStep < 2 ? _currentStep += 1 : _currentStep = 0;
                  if (_currentStep == 1) {
                    step1 = false;
                    step3 = false;
                    step2 = true;
                  } else if (_currentStep == 2) {
                    step3 = true;
                     step1 = false;
                     step2 = false;
                  } else if (_currentStep == 0){
                    step1 = true;
                    step3 = false;
                    step2 = false;
                  }
                });
              },
              steps: [
                Step(
                  state: assignState(index: _index),
                  title: const Text('Amount To Pay'),
                  content: Form(
                    key: _amountPayKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CommonTextField(
                          hintText: "e.g UGX 100,000",
                          controller: rentController,
                          titleText: "Rent: 20,000",
                          validate: (valid) {
                            setState(() {
                              errorText1 = "The rent amount field is required";
                            });
                            return null;
                          },
                          // validate: (p) => p!.isEmpty ? "Rent amount is required" : null,
                          icon: Icons.attach_money_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        CommonTextField(
                          controller: electricController,
                          hintText: "e.g 8,000",
                          titleText: "Electricity: 20,000",
                          validate: (valid) {
                            setState(() {
                              errorText1 = "Electricity amount is required";
                            });
                            return null;
                          },
                          icon: Icons.attach_money_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        CommonButton(
                          buttonText: "Proceed to payment",
                          onTap: () {
                            if (electricController.text.isEmpty &&
                                rentController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorText1),
                                  backgroundColor: Colors.redAccent,
                                  // behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 1900),
                                ),
                              );
                            } else {
                              setState(() {
                                _currentStep += 1;
                                step1 = true;
                                step3 = false;
                                step2 = false;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  isActive: step1,
                ),
                Step(
                  state: assignState(index: 1),
                  title: const Text('Select payment option'),
                  content: Column(
                    children: [
                      RadioMenuButton(
                          value: mtn,
                          groupValue: 1,
                          onChanged: (v) {
                            setState(() {
                              mtn = 1;
                              airtel = 0;
                            });
                          },
                          child: const Text("MTN")),
                      RadioMenuButton(
                          value: airtel,
                          groupValue: 1,
                          onChanged: (v) {
                            setState(() {
                              airtel = 1;
                              mtn = 0;
                            });
                          },
                          child: const Text("Airtel"))
                      //  const Radio(value: 0,)
                    ],
                  ),
                  isActive: step2,
                ),
                Step(
                  state: assignState(index: 2),
                  title: const Text('Provide your mobile money number '),
                  content: Form(
                    key: phoneFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CommonTextField(
                          titleText: "Phone Number",
                          hintText: "e.g 07xxxxxxx",
                          icon: Icons.phone,
                          contentPadding: const EdgeInsets.only(
                        left: 26,
                        right: 26,
                        top: 40,
                        bottom: 0,
                      ),
                          maxLength: 10,
                          controller: phoneNumberController,
                        ),
                        CommonButton(
                          buttonText: "Make Payment",
                          onTap: () {
                            if (phoneNumberController.text.isEmpty == false) {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return  Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Card(
                                      child: SizedBox(
                                        height: 90,
                                        child: Row(
                                          children: [
                                           const Padding(
                                             padding: EdgeInsets.only(left:18.0),
                                             child: CircularProgressIndicator(),
                                           ),
                                          const  SizedBox( width: 50,),
                                            Text("Payment in progress ",style: TextStyles(context).getRegularStyle(),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Phone number required",style: TextStyles(context).getRegularStyle(),),
                                  backgroundColor: Colors.redAccent,
                                  // behavior: SnackBarBehavior.floating,
                                  duration:  const Duration(milliseconds: 1900),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  isActive: step3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
