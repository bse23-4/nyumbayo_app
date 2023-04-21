import '/exports/exports.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty>
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
      "title": "Building name",
      "icon": Icons.home_work,
      "hint": "e.g Building..",
      "password": false,
      "type": TextInputType.name,
    },
    {
      "title": "Address",
      "icon": Icons.location_city_outlined,
      "hint": "e.g Ngobe",
      "password": false,
      "type": TextInputType.emailAddress,
    },
    {
      "title": "Number of rooms",
      "icon": Icons.room_outlined,
      "hint": "e.g 07",
      "password": false,
      "type": TextInputType.phone,
    },
  ];
  EdgeInsets padding =
      const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 2);
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
              onBackClick: () => Navigator.of(context).pop(),
              topPadding: 20,
              titlePadding:const EdgeInsets.only(left: 20, bottom: 0),
              titleText: "Add Property",
            ),
            ...[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: CommonFormFields(
                  padding: padding,
                  formEnabled: true,
                  formTitle: "Property details",
                  errorMsgs: errorMsg,
                  formFields: tenantForm,
                  formControllers: formControllers,
                  buttonText: "Save property details",
                  onSubmit: () {
                    // Navigator.of(context).pushNamed(Routes.dashboard);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
