import 'dart:ui';

import '/exports/exports.dart';
void showOptions(BuildContext context){
  showModalBottomSheet(
            barrierColor: Colors.black.withOpacity(0.7),
            backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: BottomSheet(
                    backgroundColor: Colors.transparent,
                      onClosing: () {},
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child:Stack(
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      Navigator.of(context).pushNamed(Routes.addTenant);
                                    },
                                    leading: const Icon(Icons.person_add_alt_1_outlined,color: Colors.white),
                                    title: Text("Add new tenant",style: TextStyles(context).getRegularStyle().copyWith(color: Colors.white),),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.view_list_outlined,color: Colors.white),
                                    title: Text("View Reports",style: TextStyles(context).getRegularStyle().copyWith(color: Colors.white),),
                                  ),
                                ],
                              ),
                                  Positioned(bottom:10,right:10,child: FloatingActionButton(onPressed: () {
                                    Navigator.pop(context);
                                  }, child: const Icon(Icons.close)))

                            ],
                          ),
                        );
                      }),
                );
              });
}