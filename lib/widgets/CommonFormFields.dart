// ignore_for_file: unnecessary_null_comparison

import '/exports/exports.dart';

class CommonFormFields extends StatefulWidget {
  final EdgeInsets padding;
  final String? initialPic; 
  final List<Map<String, dynamic>> formFields;
  final List<String> errorMsgs;
  final List<TextEditingController> formControllers;
  final List<dynamic>? lists;
  final void Function(dynamic)? onDropDownValue;
  final List<dynamic>? dropdownLists;
  final int? numberOfDropDowns;
  final String buttonText;
  final VoidCallback? onSubmit;
  final void Function(String?)? onSelectedValue;
  final Widget? submit;
  final String? formTitle;
  final bool formEnabled;
  const CommonFormFields(
      {super.key,
      required this.padding,
      required this.errorMsgs,
      required this.formFields,
      required this.formControllers,
      this.onSubmit,
      this.formTitle,
      this.submit,
      this.formEnabled = true,
      required this.buttonText,
      this.lists,
      this.numberOfDropDowns,
      this.dropdownLists,
       this.onDropDownValue, this.onSelectedValue, this.initialPic });

  @override
  State<CommonFormFields> createState() => _CommonFormFieldsState();
}

class _CommonFormFieldsState extends State<CommonFormFields>
    with SingleTickerProviderStateMixin {
  // Error messages

  List<String?>? dropMsg;

  @override
  void initState() {
    // Error messages
    // _errorMsg = List.generate(widget.formFields.length, (index -1) => '');
    dropMsg = List.generate(widget.formFields.length, (index) => null);

    super.initState();
    // _controller = AnimationController(vsync: this,);
  }

  // var _cropController = CropController();
  var _imageBytes;
  // PlatformFile ? _imageFile;
  // _handleImageUpload(int a) async {
  //   FilePicker.platform.pickFiles(
  //     dialogTitle: "${widget.formFields[a]['title']}",
  //     type: FileType.custom,
  //     withReadStream: true,
  //     allowedExtensions: ['jpg', 'png,', 'jpeg'],
  //   ).then((value) {
  //     // var file = value;
  //     // if (kIsWeb) {
  //       setState(() {
  //        _imageBytes = File(value!.files.first.path!).readAsBytesSync();
  //       });
  //         context.read<ImageUploadController>().uploadImage({
  //         "image":value!.files.first.readStream,
  //         "name":value.files.first.name,
  //         "size":value.files.first.size
  //        });
      // } else {
      //    setState(() {
      //   _imageBytes = File(file!.files.first.path!).readAsBytesSync();
      //   widget.formControllers[a].text = file.files.first.path!;
      // });
      // }
     
      // showDialog(
      //   context: context,
      //   builder: (context) => Dialog(
      //     child: SizedBox(
      //       // width: MediaQuery.of(context).size.width / 4,
      //       // height: MediaQuery.of(context).size.width / 4,
      //       child: CropSample(
      //         image: File(file!.files.first.path!).readAsBytesSync(),
      //         controller: _cropController,
      //         onCrop: (v) {
      //           setState(() {
      //             _imageBytes = v;
      //           });
      //           //
      //         },
      //       ),
      //     ),
      //   ),
      // );
    // });
    // widget.formControllers[a].text = = file!.files.first.pat
  // }

  // Object drawImage(Uint8List url) {
  //   if (url.isEmpty) {
  //     return widget.initialPic != null ? NetworkImage(AppUrls.liveImages + widget.initialPic!) : const AssetImage("assets/icons/001-profile.png");
  //   }
  //   return MemoryImage(url);
  // }

  String drop = '';
  Widget buildProfile(int ind) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(widget.formFields[ind]['title'],
                style: TextStyles(context).getDescriptionStyle()),
          ),
          const SizedBox(
            child: CircleAvatar(
              radius: 35,
              // backgroundImage: drawImage(_imageBytes) as ImageProvider<Object>,
            ),
          ),
          // code for uploading profile picture  using file picker
          OutlinedButtonTheme(
            data: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
                fixedSize: const Size(150, 50),
                foregroundColor: Colors.black45,
                // backgroundColor: Colors.blue,
              ),
            ),
            child: OutlinedButton(
              onPressed: () {},//=> _handleImageUpload(ind),
              child: Text(
                "Upload",
                style: TextStyles(context).getRegularStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool showPassword = false;
  // global form key
  final formKey = GlobalKey<FormState>();
  List<Widget> buildForm() {
    return List.generate(
      widget.formFields.length + 2,
      (index) => index != (widget.formFields.length + 1)
          ? index == 0
              ? Padding(
                  padding: widget.padding,
                  child: Text(
                    widget.formTitle ?? "",
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 20,
                        ),
                  ),
                )
              :
              // form fields for drop downs (gender and relationship)
              (widget.formFields[index - 1]['profile'] != null)
                  ? buildProfile(index - 1)
                  : (widget.formFields[index - 1]['data'] != null)
                      ? DropDownWidget(
                          padding: widget.padding,
                          displayText: dropMsg![index - 1] ??
                              widget.formFields[index - 1]['data'][0],
                          titleText: widget.formFields[index - 1]['title'],
                          // controller: widget.formControllers[index -1],
                          elements: widget.formFields[index - 1]['data'],
                          selectedValue: (value) {
                            // context.read<ClassNameController>().setClass(value?? '');
                            debugPrint("Selected => ${value.toString()}");
                            // widget.onSelectedValue!;
                            setState(() {
                              dropMsg![index - 1] = value;
                              widget.formControllers[index - 1].text = value!;
                            });
                          },
                        )
                      : (widget.formFields[index - 1]['date'] != null)
                          ?
                          // date of entry
                          CommonTextField(
                              icon: widget.formFields[index - 1]['icon'],
                              enableSuffix: widget.formFields[index - 1]
                                      ['enableSuffix'] ??
                                  showPassword,
                              enableBorder: true,
                              suffixIcon: widget.formFields[index - 1]
                                  ['suffix'],
                              fieldColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : const Color.fromARGB(66, 75, 74, 74),
                              errorText: widget.errorMsgs[index - 1],
                              padding: widget.padding,
                              onChanged: (v) {
                                DateTime initialDate = DateTime.now();
                                DateTime firstDate = DateTime(1990);
                                DateTime lastDate = DateTime(2050);
                                showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: firstDate,
                                        lastDate: lastDate)
                                    .then((value) {
                                  setState(() {
                                    // widget.formControllers[index - 1].text =
                                    //     "${days[value!.weekday - 1]}, ${months[(value.month) - 1]} ${markDates(value.day)}";
                                  });
                                });
                              },
                              isObscureText: widget.formFields[index - 1]
                                  ['password'],
                              controller: widget.formControllers[index - 1],
                              hintText: widget.formFields[index - 1]['hint'],
                              titleText: widget.formFields[index - 1]['title'],
                            )
                          :
                          // dropdown menu
                          (widget.formFields[index - 1]['menu'] != null)
                              ? const SingleChildScrollView(
                                  // child: CommonMenuWidget(
                                  //   fieldColor: Theme.of(context).brightness ==
                                  //           Brightness.light
                                  //       ? Colors.white
                                  //       : const Color.fromARGB(66, 75, 74, 74),
                                  //   // controller: widget.formControllers[index - 1],
                                  //   fieldText: widget.formFields[index - 1]
                                  //       ['title'],
                                  //   hint: widget.formFields[index - 1]['hint'],
                                  //   padding: widget.padding,
                                  //   onChange: widget.onDropDownValue ?? (v) {
                                  //     debugPrint("Selected => $v");
                                  //     if (v != null) {
                                  //       Provider.of<MainController>(context,listen:false)
                                  //           .selectMultiStudent(json.decode(v));
                                  //       setState(() {
                                  //         dropMsg![index - 1] = v;
                                  //         widget.formControllers[index - 1].text = v!;
                                  //       });
                                        
                                  //     }
                                           
                                  //   },
                                  //   data: widget.lists ?? context.watch<MainController>().students,
                                  //   dropdownList: widget.dropdownLists ?? [],
                                  // ),
                                )
                              :
                              // other fields
                              CommonTextField(
                                  icon: widget.formFields[index - 1]['icon'],
                                  enableSuffix: widget.formFields[index - 1]
                                          ['enableSuffix'] ??
                                      showPassword,
                                  enableBorder: true,
                                  suffixIcon: widget.formFields[index - 1]
                                      ['suffix'],
                                  fieldColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : const Color.fromARGB(66, 75, 74, 74),
                                  errorText: widget.errorMsgs[index - 1],
                                  padding: widget.padding,
                                  isObscureText: widget.formFields[index - 1]
                                      ['password'],
                                  controller: widget.formControllers[index - 1],
                                  hintText: widget.formFields[index - 1]
                                      ['hint'],
                                  titleText: widget.formFields[index - 1]
                                      ['title'],
                                  onTapSuffix: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                      widget.formFields[index - 1]['password'] =
                                          showPassword;
                                    });
                                  },
                                  validate: (v) {
                                    setState(() {
                                      widget.errorMsgs[index - 1] = v!.isEmpty
                                          ? "This field is required"
                                          : "";
                                    });

                                    return null;
                                  },
                                )
          : widget.submit ??
              CommonButton(
                buttonText: widget.buttonText,
                onTap: () {
                  if (formKey.currentState!.validate() == true) {
                    widget.onSubmit!();

                    List<String> e = widget.errorMsgs
                        .where((element) => element.isEmpty)
                        .toList();
                    //  this checks if the provided fields are empty hence no errors raised for empty fields
                    // if (e.isEmpty) {
                    // }
                  }
                },
                padding: widget.padding,
                height: 55,
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.formEnabled
        ? Form(
            key: formKey,
            child:ListView(
              children: buildForm(),
            ),
          )
        : ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: buildForm(),
          );
  }
}
