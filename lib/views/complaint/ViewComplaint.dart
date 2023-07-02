import 'dart:convert';
import 'dart:ui';

import '/exports/exports.dart';

class ViewComplaint extends StatefulWidget {
  final String title;
  final String description;
  final String status;
  final String image;
  final String date;
  const ViewComplaint(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.image,
      required this.date});

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(
            children: [
              const Space(space: 0.03),
              Center(
                child: Text(
                  "Complaint details",
                  style: TextStyles(context).getTitleStyle(),
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Title",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        trailing: Text(
                          widget.title,
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Description",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        trailing: Text(
                          widget.description,
                          style: TextStyles(context).getRegularStyle(),),
                      ),
                      ListTile(
                        title: Text(
                          "Status",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        trailing: Chip(
                          label: Text(
                            widget.status,
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(color: Colors.white),
                          ),
                          avatar: Icon(
                            widget.status == "Pending"
                                ? Icons.pending_rounded
                                : widget.status == 'Rejected'
                                    ? Icons.cancel
                                    : Icons.check_circle_rounded,
                            color: Colors.white,
                          ),
                          backgroundColor: widget.status == "Pending"
                              ? Colors.orangeAccent[700]
                              : widget.status == 'Rejected'
                                  ? Colors.red[700]
                                  : Colors.green[700],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Date",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        trailing: Text(
                          formatDate(
                            DateTime.parse(widget.date),

                          ),
                           style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Time of submission",
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        trailing: Text(
                          formatTime(
                            DateTime.parse(widget.date),
                          ),
                           style: TextStyles(context).getRegularStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            expandedHeight: MediaQuery.of(context).size.width * 0.8,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.title,
                style: TextStyles(context).getRegularStyle().copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              background: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(
                      base64.decode(widget.image),
                    ),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.black26, BlendMode.darken),
                  ),
                ),
                child: BackdropFilter(
                  blendMode: BlendMode.modulate,
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.memory(
                      base64.decode(widget.image),
                      width: 50,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ];
      },
    );
  }
}
