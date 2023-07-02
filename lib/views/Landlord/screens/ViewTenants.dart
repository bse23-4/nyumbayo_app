import 'dart:math';

import '/controllers/TenantController.dart';
import '/exports/exports.dart';

class ViewTenants extends StatefulWidget {
  const ViewTenants({super.key});

  @override
  State<ViewTenants> createState() => _ViewTenantsState();
}

class _ViewTenantsState extends State<ViewTenants>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller.forward();
    BlocProvider.of<TenantController>(context).fetchTenants(context.read<PropertyIdController>().state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PropertyIdController>(context).getPropertyId();
    BlocProvider.of<TenantController>(context).fetchTenants(context.read<PropertyIdController>().state);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    
  }

  EdgeInsets padding =
      const EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 2);
  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PropertyIdController>(context).getPropertyId();

    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              topPadding: 50,
              titleText: "Tenants",
              titlePadding: const EdgeInsets.only(left: 30),
              iconData: Icons.arrow_back,
              onBackClick: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: FutureBuilder(
                  future: Future.delayed(
                    const Duration(seconds: 3),
                  ),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Loader(
                            text: "Tenants...",
                          )
                        : BlocProvider.of<TenantController>(context)
                                .state
                                .isEmpty
                            ?  const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline,size: 100,),
                                    Space(space: 0.08),
                                    Text(
                                      "No Tenants",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return TapEffect(
                                    onClick: () {
                                      Routes.push(
                                          TenantProfile(
                                            tenantDetails: BlocProvider.of<
                                                    TenantController>(context)
                                                .state[index]
                                                .data(), id: BlocProvider.of<
                                                    TenantController>(context)
                                                .state[index].id,
                                          ),
                                          context);
                                    },
                                    child: SettingCard(
                                      padding: padding,
                                      titleText:
                                          BlocProvider.of<TenantController>(
                                                  context)
                                              .state[index]
                                              .data()['name'],
                                      subText: "Tap to view details",
                                      leading: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          backgroundColor: getRandomColor(),
                                          radius: 25,
                                          child: Text(
                                            "${BlocProvider.of<TenantController>(context).state[index].data()['name'].toString().split(" ")[0].characters.first.trim()}${BlocProvider.of<TenantController>(context).state[index].data()['name'].toString().split(" ")[1].characters.first.trim().toUpperCase()}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    BlocProvider.of<TenantController>(context)
                                        .state
                                        .length,
                                // children:

                                //  List.generate(
                                //   20,
                                //   (index) => TapEffect(
                                //     onClick: () => Routes.push(TenantProfile(), context),
                                //     child: SettingCard(
                                //       padding: padding,
                                //       titleText: "John Doe",
                                //       subText: "Tap to view details",
                                //       leading: const Padding(
                                //         padding: EdgeInsets.all(5.0),
                                //         child: CircleAvatar(
                                //           radius: 25,
                                //           child: Icon(Icons.person),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
