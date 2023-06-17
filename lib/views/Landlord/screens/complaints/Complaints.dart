import '/exports/exports.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('Complaints').snapshots(),
          builder: (context, snapshot) {
            return snapshot.data == null
                ? const Loader(
                    text: "Loading complaints...",
                  )
                : snapshot.data!.docs.isEmpty
                    ? const Center(
                        child: Text("No complaints found"),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ClipRRect(
                              child: Image.memory(
                                  base64Decode(
                                      snapshot.data!.docs[index]['image']),
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover),
                            ),
                            title: Text(snapshot.data!.docs[index]['title']),
                            subtitle:
                                Text(snapshot.data!.docs[index]['description']),
                            trailing: Text(snapshot.data!.docs[index]['']),
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
