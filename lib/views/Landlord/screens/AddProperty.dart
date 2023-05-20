import '/exports/exports.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
List<TextEditingController> formControllers =
        List.generate(4, (index) => TextEditingController());
 

  final List<Map<String, dynamic>> _propertyForm = [
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
      "title": "Number of floors",
      "icon": Icons.room_outlined,
      "hint": "e.g 07",
      "password": false,
      "type": TextInputType.phone,
    },
    {
      "title": "Number of apartments",
      "icon": Icons.room_outlined,
      "hint": "e.g 07",
      "password": false,
      "type": TextInputType.phone,
    },
  ];
 @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller.forward();
   
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // padding settings
  EdgeInsets padding =
      const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 2);
  @override
  Widget build(BuildContext context) {
    List<String> errorMsg = List.generate(4, (index) => "");
    // ignore: prefer_typing_uninitialized_variables
    
// trigger user id
BlocProvider.of<UserdataController>(context).getUserData();
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbarView(
                iconData: Icons.arrow_back,
                onBackClick: () => Navigator.of(context).pop(),
                topPadding: 20,
                titlePadding: const EdgeInsets.only(
                  left: 20,
                  bottom: 0,
                  top: 30,
                ),
                titleText: "Add Property",
              ),
              ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: CommonFormFields(
                    padding: padding,
                    formTitle: "Property details",
                    errorMsgs: errorMsg,
                    formEnabled: true,
                    formFields: _propertyForm,
                    formControllers: formControllers,
                    buttonText: "Save property details",
                    onSubmit: () {
                      var data = {
                        
                        "name": formControllers[0].text,
                        "address": formControllers[1].text,
                        "floors": formControllers[2].text,
                        "rooms": formControllers[3].text,
                        "date": DateTime.now().toString(),
                      };
                      showProgress(context, text: "Adding new property...");
                      Properties.addProperty(data,context.read<UserdataController>().state).then((value) {
                        Routes.pop(context);
                      }).whenComplete(
                        () {
                          Routes.named(context, Routes.dashboard);
                          showMessage(
                              context: context,
                              msg: "Property added successfully",
                              type: 'success');
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
