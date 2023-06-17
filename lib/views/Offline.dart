import '/exports/exports.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Space(space: 0.3),
          Icon(Icons.wifi_off_sharp, color: Colors.red, size: 100),
          Space(space: 0.3),
          Text("No Internet Connection"),
          Space(space: 0.3),
          Text("Please check your internet connection"),
          Space(space: 0.3),
          Space(space: 0.3),
          Space(space: 0.3),
        ],
      ),
    );
  }
}
