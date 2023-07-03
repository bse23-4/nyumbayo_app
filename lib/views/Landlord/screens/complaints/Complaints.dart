import '/exports/exports.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> pending = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('complaints').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
             pending = snapshot.data!.docs.where((element) => element.data()['status'] == "Pending").toList();
            }
            return snapshot.connectionState == ConnectionState.waiting
                ? const Loader(
                    text: "complaints...",
                  )
                : pending.isEmpty
                    ? const NoDataWidget(
                        text: "No complaints available",
                      )
                    : ListView.builder(
                        itemCount: pending.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ClipRRect(
                              child: Image.memory(
                                base64Decode(
                                    pending[index]['image']),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(pending[index]['title']),
                            subtitle:
                                Text(pending[index]['description']),
                            trailing: Text(pending[index]['']),
                          );
                        });
          },
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text("Complaints"),
              pinned: true,
              floating: true,
              snap: true,
              centerTitle: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/6184498.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
