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
    }
  ];
  EdgeInsets padding =
      const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2);
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
              topPadding: 20,
              titlePadding:
                  const EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 4),
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
                  showProgress(context,text:"Tenant details saved");
                     var prop = Tenants(name: formControllers[0].text, email: formControllers[1].text, contact: formControllers[2].text, address: formControllers[3].text, roomNumber: formControllers[4].text, monthlyRent: formControllers[5].text);
                      TenantData.saveTenantDetails(prop).then((value) {
                        Routes.pop(context);
                      }).whenComplete((){
                        showMessage(context: context,msg: "Tenant details saved successfully..");
                   });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
