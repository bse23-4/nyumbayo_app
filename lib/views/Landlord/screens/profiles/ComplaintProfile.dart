import 'dart:ui';

import 'package:nyumbayo_app/exports/exports.dart';

import 'widgets/BottomMenu.dart';
import 'widgets/RejectBottomMenu.dart';

class ComplaintProfile extends StatefulWidget {
  final String title;
  final String description;
  final String tenantId;
  final String status;
  final String image;
  final String date;
  const ComplaintProfile(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.image,
      required this.date,
      required this.tenantId});

  @override
  State<ComplaintProfile> createState() => _ComplaintProfileState();
}

class _ComplaintProfileState extends State<ComplaintProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(
        milliseconds: 900,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EdgeInsets padding = const EdgeInsets.only(left: 10, right: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: NestedScrollView(
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Space(space: 0.04),
              Card(
                elevation: 1,
                color: Colors.white,
                margin: padding,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Complaint title",
                          style: TextStyle(fontSize: 16)),
                      trailing: Text(
                        widget.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Description",
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        widget.description,
                        // style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Date",
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        formatDate(
                          DateTime.parse(widget.date),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Time",
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        formatTime(
                          DateTime.parse(widget.date),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              context
                                  .read<MainController>()
                                  .captureTenantId(widget.tenantId);
                              showBottomMenu(
                                  context.read<MainController>().tenantId);
                            },
                            icon: const Icon(Icons.check),
                            label: const Text(
                              "Resolve",
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              context
                                  .read<MainController>()
                                  .captureTenantId(widget.tenantId);
                              showRejectBottomMenu(
                                  context.read<MainController>().tenantId);
                            },
                            icon: const Icon(Icons.close),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            label: const Text("Reject"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Space(space: 0.02),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                floating: true,
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.width,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.title),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                          base64Decode(widget.image),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                          color: Colors.black.withOpacity(0.2),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 68.0, bottom: 68.0),
                            child: Image.memory(
                              base64.decode(widget.image),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }

  // bottom menu
  void showBottomMenu(String tenantId) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: BottomMenu(id: tenantId),
              );
            },
            onClosing: () {},
          );
        });
  }

  // show rejection options
  void showRejectBottomMenu(String tenantId) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: RejectBottomMenu(tenantId: tenantId),
              );
            },
            onClosing: () {},
          );
        });
  }
}
