import '/exports/exports.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({super.key});

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
      body: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Center(child: Text("Complaint status"),)
            ],
          ),
        ),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Complaints",
                style: TextStyles(context).getBoldStyle(),
              ),
              background: Image.asset(
                "assets/images/apartment1.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
    );
  }
}
