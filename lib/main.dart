// // ignore_for_file: library_private_types_in_public_api, avoid_print

// //import 'dart:io';

// //import 'package:firebase_core/firebase_core.dart';
// //import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// //import 'package:image_picker/image_picker.dart';
// //import 'package:path/path.dart' as path;
// //import 'firebase_options.dart';
// //import 'package:flutter_image_ppicker/home_screen.dart';

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     // initialize Firebase using the DefaultFirebaseOptions object exported by the configuration file
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
//  runApp(const MyApp());
// //  // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   Initialize a new Firebase App instance
// //   await Firebase.initializeApp();
// //   runApp(const MyApp());
// //  }
// //for images in our app
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       // Remove the debug banner
// //       debugShowCheckedModeBanner: false,
// //       title: 'Kindacode.com',
// //       theme: ThemeData(primarySwatch: Colors.green),
// //       home: const HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget {
// //   const HomePage({Key? key}) : super(key: key);

// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   FirebaseStorage storage = FirebaseStorage.instance;

// //   // Select and image from the gallery or take a picture with the camera
// //   // Then upload to Firebase Storage
// //   Future<void> _upload(String inputSource) async {
// //     final picker = ImagePicker();
// //     XFile? pickedImage;
// //     try {
// //       pickedImage = await picker.pickImage(
// //           source: inputSource == 'camera'
// //               ? ImageSource.camera
// //               : ImageSource.gallery,
// //           maxWidth: 1920);

// //       final String fileName = path.basename(pickedImage!.path);
// //       File imageFile = File(pickedImage.path);

// //       try {
// //         // Uploading the selected image with some custom meta data
// //         await storage.ref(fileName).putFile(
// //             imageFile,
// //             SettableMetadata(customMetadata: {
// //               'uploaded_by': 'A bad guy',
// //               'description': 'Some description...'
// //             }));

// //         // Refresh the UI
// //         setState(() {});
// //       } on FirebaseException catch (error) {
// //         if (kDebugMode) {
// //           print(error);
// //         }
// //       }
// //     } catch (err) {
// //       if (kDebugMode) {
// //         print(err);
// //       }
// //     }
// //   }

//   // Retriew the uploaded images
//   // This function is called when the app launches for the first time or when an image is uploaded or deleted
// //   Future<List<Map<String, dynamic>>> _loadImages() async {
// //     List<Map<String, dynamic>> files = [];

// //     final ListResult result = await storage.ref().list();
// //     final List<Reference> allFiles = result.items;

// //     await Future.forEach<Reference>(allFiles, (file) async {
// //       final String fileUrl = await file.getDownloadURL();
// //       final FullMetadata fileMeta = await file.getMetadata();
// //       files.add({
// //         "url": fileUrl,
// //         "path": file.fullPath,
// //         "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
// //         "description":
// //             fileMeta.customMetadata?['description'] ?? 'No description'
// //       });
// //     });

// //     return files;
// //   }

// //   // Delete the selected image
// //   // This function is called when a trash icon is pressed
// //   Future<void> _delete(String ref) async {
// //     await storage.ref(ref).delete();
// //     // Rebuild the UI
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Kindacode.com'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 ElevatedButton.icon(
// //                     onPressed: () => _upload('camera'),
// //                     icon: const Icon(Icons.camera),
// //                     label: const Text('camera')),
// //                 ElevatedButton.icon(
// //                     onPressed: () => _upload('gallery'),
// //                     icon: const Icon(Icons.library_add),
// //                     label: const Text('Gallery')),
// //               ],
// //             ),
// //             Expanded(
// //               child: FutureBuilder(
// //                 future: _loadImages(),
// //                 builder: (context,
// //                     AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.done) {
// //                     return ListView.builder(
// //                       itemCount: snapshot.data?.length ?? 0,
// //                       itemBuilder: (context, index) {
// //                         final Map<String, dynamic> image =
// //                             snapshot.data![index];

// //                         return Card(
// //                           margin: const EdgeInsets.symmetric(vertical: 10),
// //                           child: ListTile(
// //                             dense: false,
// //                             leading: Image.network(image['url']),
// //                             title: Text(image['uploaded_by']),
// //                             subtitle: Text(image['description']),
// //                             trailing: IconButton(
// //                               onPressed: () => _delete(image['path']),
// //                               icon: const Icon(
// //                                 Icons.delete,
// //                                 color: Colors.red,
// //                               ),
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   }

// //                   return const Center(
// //                     child: CircularProgressIndicator(),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // Try running your application with "flutter run". You'll see the
// //         // application has a blue toolbar. Then, without quitting the app, try
// //         // changing the primarySwatch below to Colors.green and then invoke
// //         // "hot reload" (press "r" in the console where you ran "flutter run",
// //         // or simply save your changes to "hot reload" in a Flutter IDE).
// //         // Notice that the counter didn't reset back to zero; the application
// //         // is not restarted.
// //         primarySwatch: Colors.red,
// //       ),
// //       home: const MyHomePage(title: 'NyumbaYo App'),
// //     );
// //   }
// // }

// //for images
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'This is Nyumbayo app********:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
