import 'package:nyumbayo_app/exports/exports.dart';

class ComplaintProfile extends StatefulWidget {
  const ComplaintProfile({super.key});

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

  EdgeInsets padding = const EdgeInsets.only(left: 20, right: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonAppbarView(
              headerWidget: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox.shrink(),
                    RichText(
                      text: TextSpan(
                        text: "Complaint\n",
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(fontSize: 20),
                        children: [
                          TextSpan(
                            text: "john@gmail.com",
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue.shade50,
                      child: Text(
                        "C",
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.title_outlined,
                size: 35,
              ),
              title: Text("Title", style: TextStyles(context).getBoldStyle()),
              subtitle: Text(
                "title here",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.report_problem,
                size: 35,
              ),
              title: Text("Issue", style: TextStyles(context).getBoldStyle()),
              subtitle: Text(
                "Description",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.image,
                size: 35,
              ),
              title: Text("Issue Snapshot",
                  style: TextStyles(context).getBoldStyle()),
              subtitle: Image.asset(
                "assets/6184498.png",
                height: 200,
                width: 200,
              ),
            ),
            const Divider(),
            const Space(space: 0.04),
            CommonButton(
              buttonText: "Resolve",
              height: 55,
              backgroundColor: Colors.green.shade500,
              padding: padding,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.width / 3,
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                                "Are you sur you want to resolve this issue?"),
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Approve"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                "Reject this issue",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
