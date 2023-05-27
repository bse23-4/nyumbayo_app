import 'dart:convert';

import '/exports/exports.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  // /controllers
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController(); 
  Uint8List? _byteImage;
  String? _base64Image;
  String options = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              titlePadding: const EdgeInsets.only(
                left: 18.0,
                top: 20,
              ),
              titleText: "Add Complaints",
              iconData: Icons.arrow_back,
              onBackClick: () => Routes.pop(context),
            ),
            const Space(space: 0.03),
            Expanded(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RadioListTile(
                        selected: options == "power surge" ? true : false,
                        value: "Power Surge",
                        groupValue: options,
                        onChanged: (v) {
                          setState(() {
                            options = v ?? "";
                          });
                        },
                        title: Text(
                          "Power Surge",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      RadioListTile(
                        selected: options == "brokages" ? true : false,
                        value: "Brokages",
                        groupValue: options,
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            options = v ?? "";
                          });
                        },
                        title: Text(
                          "Brokages",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      RadioListTile(
                        selected: options == "others" ? true : false,
                        value: "Others",
                        groupValue: options,
                        onChanged: (v) {
                          setState(() {
                            options = v ?? "";
                          });
                        },
                        title: Text(
                          "Others",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      if (options == "Others") const Space(space: 0.02),
                      if (options == "Others")
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, right: 28, bottom: 20),
                          child: Text(
                            "Specify",
                            style: TextStyles(context).getRegularStyle(),
                          ),
                        ),
                        if (options == "Others")
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28),
                        child: TextFormField(
                          controller: _titleController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            hintText: "Specify the kind of complaint",
                            hintTextDirection: TextDirection.ltr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyles(context).getRegularStyle(),
                          ),
                        ),
                      ),
                      const Space(space: 0.03),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28, bottom: 20),
                        child: Text(
                          "Description",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28),
                        child: TextFormField(
                            controller: _descriptionController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              hintText:
                                  "Provide a description of your complaint",
                              hintTextDirection: TextDirection.ltr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintStyle:
                                  TextStyles(context).getDescriptionStyle(),
                            )),
                      ),
                      // image upload widget
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 28.0,
                          right: 28,
                          bottom: 20,
                          top: 20,
                        ),
                        child: Text(
                          "Capture complaint",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                child: _byteImage != null? Image.memory(_byteImage!) : Image.asset(
                                    "assets/images/profile_pic.jpg")),
                          ),
                          TapEffect(
                            onClick: ()  {
                              uploadImage()
                              .then((value){
                                  setState(() {
                                    _base64Image = base64Encode(value.readAsBytesSync());
                                    _byteImage = value.readAsBytesSync();
                                  });
                              })
                              .whenComplete((){
                                showMessage(context: context, msg: "Image Uploaded Successfully", type: "success");
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 45),
                              child: CircleAvatar(
                                radius: 40,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Space(space: 0.03),
                      CommonButton(
                        buttonText: "Submit",
                        onTap: () {
                          showProgress(context, text: "Submitting Complaint");
                          if (_formKey.currentState!.validate()) {
                            Database.insertOne("complaints", {
                              "description": _descriptionController.text,
                              "title": options == 'Others'?_titleController.text:options,
                              "date": DateTime.now().toString(),
                              "status": "Pending",
                              "image": _base64Image ?? "",
                            }).then((value) {
                              Routes.pop(context);
                            }).whenComplete(() {
                              Routes.pop(context);
                              showMessage(
                                  context: context,
                                  msg: "Complaint Submitted successfully",
                                  type: "success");
                            });
                          }
                        },
                        height: 55,
                        padding: const EdgeInsets.only(left: 25.0, right: 25),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
