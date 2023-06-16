// import 'dart:convert';

import '/exports/exports.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  @override
  void initState() {
    super.initState();
    // context.read<MainController>().fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<MainController>(context, listen: true).fetchComplaints();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
              child: Text(
                "Complaints",
                style: TextStyles(context)
                    .getTitleStyle()
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: Future.delayed(Duration.zero),//Database.fetchAll("complaints"),
                  builder: (context, s) {
                    // var data = s.data;
                    // return s.hasData == false
                    return s.connectionState == ConnectionState.waiting
                        ? const Loader(
                            text: "Complaints",
                          )
                        :  NoDataWidget(text: "No Complaints");
                            // : s.data!.isEmpty
                            // ? const NoDataWidget(text: "No Complaints") : Container();
                            // : ListView.builder(
                            //     itemCount: data?.length,
                            //     itemBuilder: (ctx, i) {
                            //       var t = data?[i];
                            //       return ListTile(
                            //         onTap: () {},
                            //         leading: CircleAvatar(
                            //           radius: 40,
                            //           backgroundImage: MemoryImage(
                            //             base64.decode(
                            //               t?['image'],
                            //             ),
                            //           ),
                            //         ),
                            //         title: Text("${t?['title']}",
                            //             style: TextStyles(context)
                            //                 .getRegularStyle()),
                            //         subtitle: Text(
                            //             formatDate(DateTime.parse(t?['date'])),
                            //             style: TextStyles(context)
                            //                 .getDescriptionStyle()),
                            //         trailing: Text(
                            //             "${t?['status']}"
                            //                     .characters
                            //                     .first
                            //                     .toUpperCase() +
                            //                 "${t?['status']}".substring(1),
                            //             style: TextStyles(context)
                            //                 .getDescriptionStyle()),
                            //       );
                            //     });
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Routes.push(const AddComplaint(), context),
        icon: const Icon(Icons.add),
        label: const Text("Add Complaint"),
      ),
    );
  }
}
