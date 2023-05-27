import '/exports/exports.dart';

import 'Home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final icons = [
    const Icon(Icons.home),
    const Icon(Icons.file_copy_sharp),
    const Icon(Icons.person_4),
  ];
  final labels = [
    "Home",
    "Complaints",
    "Profile",
  ];
  int _page = 0;
  // pages
  List<Widget> pages = [const Home(), const Complaint(), const ProfileScreen()];

  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyles(context).getRegularStyle().copyWith(
          fontSize: 12
        ), selectedLabelStyle: TextStyles(context).getRegularStyle().copyWith(
          fontSize: 12
        ),
        currentIndex:_page ,
        onTap: (x){
          setState(() {
            _page = x;
          });
          _pageController.animateToPage(x, duration: const Duration(milliseconds: 500), curve: Curves.easeInSine);
        },
        items: List.generate(
          3,
          (index) =>
              BottomNavigationBarItem(icon: icons[index], label: labels[index]),
        ),
      ),
    );
  }
}
