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
    context.read<MainController>().fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MainController>(context, listen: true).fetchComplaints();
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
            if (context.watch<MainController>().complaints.isEmpty)
              const NoDataWidget(
                text: "No Complaints",
              ),
            Expanded(
              child: FutureBuilder(
                  future: Database.fetchAll("complaints"),
                  builder: (context, s) {
                    var d = s.data;
                    return s.connectionState == ConnectionState.waiting
                        ? const Loader(
                            text: "Complaints",
                          )
                        : ListView.builder(
                            itemCount: d?.length,
                            itemBuilder: (ctx, i) {
                              var data =
                                  context.watch<MainController>().complaints[i];
                              return ListTile(
                                onTap: () {},
                                leading: const Icon(Icons.file_copy),
                                title: Text("${data['title']}"),
                                subtitle: Text(formatDate(DateTime.now())),
                                trailing: Text("${data['status']}"),
                              );
                            });
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
