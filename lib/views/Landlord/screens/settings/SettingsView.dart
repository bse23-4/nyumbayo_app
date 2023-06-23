import 'dart:ui';

import '/exports/exports.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 800),
    );
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller!,
        child: NestedScrollView(
          body: ListView(
            children:  [
              ListTile(
                leading: const Icon(
                  Icons.percent_rounded,
                ),
                title: const Text("Percentage amount to be paid"),
                subtitle: Text("Amount 10%",style:TextStyles(context).getDescriptionStyle()),
                onTap: (){},
              ), ListTile(
                leading: const Icon(
                  Icons.percent_rounded,
                ),
                title: const Text("Electricity amount to be paid"),
                subtitle: Text("Amount 10%",style:TextStyles(context).getDescriptionStyle()),
                onTap: (){},
              ), ListTile(
                leading: const Icon(
                  Icons.access_time,
                ),
                title: const Text("Period of time power should be reconnected"),
                subtitle: Text("Time period 2mins",style:TextStyles(context).getDescriptionStyle()),
                onTap: (){},
              ),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: MediaQuery.of(context).size.width,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Settings",
                        style: TextStyles(context)
                            .getTitleStyle()
                            .copyWith(color: Colors.white)),
                    background: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          scale: 2,
                          colorFilter: ColorFilter.mode(
                              Colors.black26, BlendMode.darken),
                          fit: BoxFit.cover,
                          image: AssetImage("assets/house.png"),
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 20,
                          sigmaY: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(60),
                          child: SizedBox(
                            child: Image.asset(
                              "assets/house.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    )),
              )
            ];
          },
        ),
      ),
    );
  }
}
