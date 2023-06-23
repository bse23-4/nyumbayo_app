import 'dart:convert';

import 'package:nyumbayo_app/views/complaint/widgets/CameraWidget.dart';

import '../../backend/complaints.dart';
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
                top: 10,
              ),
              titleText: "Add Complaints",
              iconData: Icons.arrow_back,
              onBackClick: () => Routes.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 3, bottom: 0),
              child: Text(
                "Select the appropriate complaint you want to raise..",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            const Space(space: 0.01),
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
                        selected: options == "Plumbing issues" ? true : false,
                        value: "Plumbing issues",
                        groupValue: options,
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            options = v ?? "";
                          });
                        },
                        title: Text(
                          "Plumbing issues",
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
                            child: PhysicalModel(
                              elevation: 20,
                              color: Colors.white24,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: _byteImage != null
                                      ? Image.memory(
                                          _byteImage!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/house.png",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          TapEffect(
                            onClick: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                        backgroundColor: Colors.transparent,
                                        onClosing: () {},
                                        builder: (context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CameraWidget(
                                                    onClick: () {
                                                      uploadImage()
                                                          .then((value) {
                                                        setState(() {
                                                          _base64Image =
                                                              base64Encode(value
                                                                  .readAsBytesSync());
                                                          _byteImage = value
                                                              .readAsBytesSync();
                                                        });
                                                      }).whenComplete(() {
                                                        showMessage(
                                                          context: context,
                                                          msg:
                                                              "Image Uploaded Successfully",
                                                          type: "success",
                                                        );
                                                        Routes.pop(context);
                                                      });
                                                    },
                                                    title: "Camera",
                                                    icon: Icons.camera_sharp,
                                                  ),
                                                  CameraWidget(
                                                    onClick: () {
                                                      captureImage()
                                                          .then((value) {
                                                        setState(() {
                                                          _base64Image =
                                                              base64Encode(value
                                                                  .readAsBytesSync());
                                                          _byteImage = value
                                                              .readAsBytesSync();
                                                        });
                                                      }).whenComplete(() {
                                                        showMessage(
                                                          context: context,
                                                          msg:
                                                              "Image Uploaded Successfully",
                                                          type: "success",
                                                        );
                                                        Routes.pop(context);
                                                      });
                                                    },
                                                    title: "Gallery",
                                                    icon: Icons
                                                        .photo_library_rounded,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  });
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 25.0, right: 45),
                              child: CircleAvatar(
                                radius: 40,
                                child: Icon(
                                  Icons.attachment,
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
                          if (options == "" || options.isEmpty) {
                            showAlertMsg(
                                 context,
                                content: "Please select a complaint",
                                );
                          } else if (options == "Others" &&
                              _titleController.text.isEmpty) {
                            showAlertMsg(
                                 context,
                                content: "Please specify the complaint",
                                );
                          } else if (_descriptionController.text.isEmpty) {
                            showAlertMsg(
                                 context,
                                content: "Please provide a description",
                                );
                          } else {
                            showProgress(context, text: "Submitting Complaint");
// Submitting the complaint to landlord via Firebase firestore
                            Complaints.raiseComplaint({
                              "tenant_id":
                                  FirebaseAuth.instance.currentUser?.uid,
                                  "property_id": context.read<TenantController>().state['property'],
                              "description": _descriptionController.text,
                              "title": options == 'Others'
                                  ? _titleController.text
                                  : options,
                              "date": DateTime.now().toString(),
                              "status": "Pending",
                              'reason':'',
                              "image": _base64Image ?? "",
                            })
                                .then((value) {
                              Routes.pop(context);
                            }).whenComplete(() {
                              Routes.pop(context);
                              showMessage(
                                  context: context,
                                  msg: "Complaint Submitted successfully",
                                  type: "success");
                            });
                            // end of submitting of complaint
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
