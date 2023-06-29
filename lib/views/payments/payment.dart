// ignore_for_file: use_build_context_synchronously

import 'package:nyumbayo_app/models/Tenants.dart';

import '../../backend/payments.dart';
import '../../models/Payment.dart';
import '/exports/exports.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    BlocProvider.of<UserdataController>(context).getUserData();

    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<UserdataController>().state);
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller?.forward();
  }

  int _currentStep = 0;
  final rentController = TextEditingController();
  final electricController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String errorText1 = '';
  @override
  void dispose() {
    _controller?.dispose();
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
    // initialisations
    BlocProvider.of<UserdataController>(context).getUserData();

    BlocProvider.of<TenantController>(context)
        .fetchTenants(context.read<UserdataController>().state);
    EdgeInsets padding = MediaQuery.of(context)
        .padding
        .copyWith(top: 10, bottom: 10, left: 10, right: 10);

    context.watch<MainController>().fetchPowerConsumed();

    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller!,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonAppbarView(
                titleText: "Payment Process",
                titlePadding: const EdgeInsets.only(top: 20, left: 20),
                iconData: Icons.arrow_back_ios,
                onBackClick: () => Navigator.pop(context),
                topPadding: 30,
              ),
              Stepper(
                currentStep: _currentStep,
                onStepCancel: step3 == true
                    ? null
                    : () {
                        setState(() {
                          _index = 0;
                          _currentStep > 0
                              ? _currentStep -= 1
                              : _currentStep = 0;
                        });
                      },
                onStepContinue: step3 == true
                    ? null
                    : () {
                        setState(() {
                          _currentStep < 2
                              ? _currentStep += 1
                              : _currentStep = 0;
                          if (_currentStep == 1) {
                            step1 = false;
                            step3 = false;
                            step2 = true;
                          } else if (_currentStep == 2) {
                            step3 = true;
                            step1 = false;
                            step2 = false;
                          } else if (_currentStep == 0) {
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
                            padding: padding,
                            enableBorder: true,
                            hintText: "e.g UGX 100,000",
                            controller: rentController,
                            titleText:
                                "Rent: UGX: ${context.read<TenantController>().state['balance']}",
                            validate: (valid) {
                              setState(() {
                                errorText1 =
                                    "The rent amount field is required";
                              });
                              return null;
                            },
                            // validate: (p) => p!.isEmpty ? "Rent amount is required" : null,
                            icon: Icons.attach_money_outlined,
                            keyboardType: TextInputType.number,
                          ),
                          CommonTextField(
                            padding: padding,
                            enableBorder: true,
                            controller: electricController,
                            hintText: "e.g 8,000",
                            titleText:
                                "Electricity: UGX:${context.read<TenantController>().state['power_fee']}",
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
                            padding: padding,
                            buttonText: "Proceed to payment",
                            onTap: () {
                              if (electricController.text.isEmpty &&
                                  rentController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorText1),
                                    backgroundColor: Colors.redAccent,
                                    // behavior: SnackBarBehavior.floating,
                                    duration:
                                        const Duration(milliseconds: 1900),
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
                          child: const Text(
                            "MTN",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        RadioMenuButton(
                          value: airtel,
                          groupValue: 1,
                          onChanged: (v) {
                            setState(() {
                              airtel = 1;
                              mtn = 0;
                            });
                          },
                          child: const Text(
                            "Airtel",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        )
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
                            enableBorder: true,
                            icon: Icons.phone,
                            contentPadding: const EdgeInsets.only(
                              left: 26,
                              right: 26,
                              top: 90,
                              bottom: 0,
                            ),
                            maxLength: 10,
                            controller: phoneNumberController,
                          ),
                          CommonButton(
                            buttonText: "Make Payment",
                            onTap: () {
                              if (phoneNumberController.text.isEmpty == false) {
                                if (context
                                            .read<TenantController>()
                                            .state['contact'] ==
                                        phoneNumberController.text ||
                                    context
                                            .read<TenantController>()
                                            .state['acontact'] ==
                                        phoneNumberController.text) {
                              //  show payment loader
                              showProgressLoader(context);

                                  FirebaseFirestore.instance
                                      .collection("tenants")
                                      .doc(context
                                          .read<UserdataController>()
                                          .state)
                                      .update({
                                    "amountPaid": rentController.text.isEmpty
                                        ? context
                                            .read<TenantController>()
                                            .state['amountPaid']
                                        : (int.parse(context
                                                    .read<TenantController>()
                                                    .state['amountPaid']) +
                                                int.parse(rentController.text))
                                            .toString(),
                                    "balance": (int.parse(context
                                                .read<TenantController>()
                                                .state['balance']) -
                                            int.parse(rentController.text))
                                        .toString(),
                                    "power_fee": electricController.text.isEmpty
                                        ? context
                                            .read<TenantController>()
                                            .state['power_fee']
                                        : (int.parse(context
                                                    .read<TenantController>()
                                                    .state['power_fee']) -
                                                int.parse(
                                                    electricController.text))
                                            .toString(),
                                  }).then((event) {
                                    // Routes.pop(context);
                                  
                                   

                                    Routes.push(const Dashboard(), context);

                                  
 // save payment details
                                        showMessage(
                                        context: context,
                                        msg: "Payment made successfully",
                                        type: 'success');
                                    // navigate to dashboard
                                  })
                                  .whenComplete(() {

                                    // trigger notification
                                    sendNotification(
                                      title: "Payment",
                                      body: "Payment made successfully",
                                    );
                                  });
                                  // record payment
                                     Payments.makePayments(
                                      Payment(
                                        amount:
                                            rentController.text.isEmpty
                                        ? context
                                            .read<TenantController>()
                                            .state['amountPaid']
                                        : (int.parse(context
                                                    .read<TenantController>()
                                                    .state['amountPaid']) +
                                                int.parse(rentController.text))
                                            .toString(),
                                        balance: context
                                            .read<TenantController>()
                                            .state['balance'],
                                        tenantId: context
                                            .read<UserdataController>()
                                            .state,
                                        property: context
                                            .read<TenantController>()
                                            .state['property'],
                                        date: DateTime.now().toString(),
                                        tenantName: context
                                            .read<TenantController>()
                                            .state['name'],
                                        electricityBill:
                                            "${context.watch<MainController>().computeBill(context.watch<MainController>().powerConsumed)}",
                                      ),
                                    );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Phone number does not match",
                                        style: TextStyles(context)
                                            .getRegularStyle(),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      // behavior: SnackBarBehavior.floating,
                                      duration:
                                          const Duration(milliseconds: 1900),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Phone number required",
                                      style:
                                          TextStyles(context).getRegularStyle(),
                                    ),
                                    backgroundColor: Colors.redAccent,
                                    // behavior: SnackBarBehavior.floating,
                                    duration:
                                        const Duration(milliseconds: 1900),
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
      ),
    );
  }
}
