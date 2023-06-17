import '/exports/exports.dart';

class AddTenant extends StatefulWidget {
  const AddTenant({super.key});

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant>
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> tenantForm = [
    {
      "title": "Tenant's name",
      "icon": Icons.person,
      "hint": "e.g John Doe",
      "password": false,
      "type": TextInputType.name,
    },
    {
      "title": "Email",
      "icon": Icons.email,
      "hint": "e.g example@example.com",
      "password": false,
      "type": TextInputType.emailAddress,
    },
    {
      "title": "Contact",
      "icon": Icons.phone,
      "hint": "e.g 075xxxxx",
      "password": false,
      "type": TextInputType.phone,
    }, {
      "title": "Another Contact",
      "icon": Icons.phone,
      "hint": "e.g 077xxxxx",
      "password": false,
      "type": TextInputType.phone,
    },
    {
      "title": "Home Address",
      "icon": Icons.home,
      "hint": "e.g Address",
      "password": false,
      "type": TextInputType.name,
    },
    {
      "title": "Room Number",
      "icon": Icons.room_outlined,
      "hint": "e.g Room 4",
      "password": false,
      "type": TextInputType.number,
    },
    {
      "title": "Monthly Rent",
      "icon": Icons.monetization_on_outlined,
      "hint": "e.g 5000",
      "password": false,
      "type": TextInputType.number,
    }, {
      "title": "Amount Paid",
      "icon": Icons.monetization_on_outlined,
      "hint": "e.g 5000",
      "password": false,
      "type": TextInputType.number,
    }
  ];
  EdgeInsets padding =
      const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2);
  @override
  Widget build(BuildContext context) {
    List<String> errorMsg = List.generate(tenantForm.length, (index) => "");
    List<TextEditingController> formControllers =
        List.generate(tenantForm.length, (index) => TextEditingController());
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              iconData: Icons.arrow_back,
              topPadding: 40,
              titlePadding:
                  const EdgeInsets.only(left: 30, top: 4, right: 10, bottom: 0),
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Add Tenant",
            ),
            Expanded(
              child: CommonFormFields(
                padding: padding,
                formEnabled: true,
                formTitle: "Tenant details",
                errorMsgs: errorMsg,
                formFields: tenantForm,
                formControllers: formControllers,
                buttonText: "Save tenant details",
                onSubmit: () {
                  // check if all fields have data
                  if (formControllers[0].text.isEmpty ||
                      formControllers[1].text.isEmpty ||
                      formControllers[2].text.isEmpty ||
                      formControllers[3].text.isEmpty ||
                      formControllers[4].text.isEmpty ||
                      formControllers[5].text.isEmpty ||
                      formControllers[6].text.isEmpty ||
                      formControllers[7].text.isEmpty) {
                    showMessage(
                        context: context,
                        msg: "Please fill in all the fields",type:"danger");
                    return;
                  } else {
                  showProgress(context, text: "Saving tenant details..");
                  // if()
                  var prop = Tenants(
                    name: formControllers[0].text,
                    email: formControllers[1].text,
                    contact: formControllers[2].text,
                    acontact: formControllers[3].text,
                    address: formControllers[4].text,
                    roomNumber: formControllers[5].text,
                    monthlyRent: formControllers[6].text,
                    amountPaid: formControllers[7].text,
                  );
                  TenantData.saveTenantDetails(prop,context.read<PropertyIdController>().state).then((value) {
                    Routes.pop(context);
                  }).whenComplete(() {
                    Routes.named(context, Routes.dashboard);
                    showMessage(
                        context: context,
                        msg: "Tenant details saved successfully..");
                  });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
