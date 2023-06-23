import 'package:nyumbayo_app/tools/Reload.dart';

import '/exports/exports.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          const Icon(Icons.wifi_off_sharp, color: Colors.red, size: 100),
      
          Center(child: Text("No Internet Connection",style: TextStyles(context).getRegularStyle(),)),
    
          const Text("Please check your internet connection",style:  TextStyle(fontSize: 18),),
        const Space(space: 0.03),
        ElevatedButton.icon(onPressed: () => ReloadApp.restartApp(context), icon: Icon(Icons.refresh_rounded), label: const Text("Refresh"))
        ],
      ),
    );
  }
}
