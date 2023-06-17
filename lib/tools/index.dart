import '/exports/exports.dart';

showAlertMsg(BuildContext context,{String title = "" , String content = ""}){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(title,style:TextStyles(context).getRegularStyle()),
                        content:  Text(content,style:TextStyles(context).getRegularStyle()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Okay"),
                          ),
                          // TextButton(
                          //   onPressed: () => Navigator.of(context).pop(),
                          //   child: const Text("Yes"),
                          // ),
                        ],
                      ),
                    );
                  }