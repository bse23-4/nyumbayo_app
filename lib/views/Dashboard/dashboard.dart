import 'package:flutter/material.dart';
import 'package:nyumbayo_app/constants/colors.dart';
class Dashboard extends StatelessWidget{
   const Dashboard({Key? key}) : super (key : key);

   @override
   Widget build(BuildContext context){
   return Scaffold(
    backgroundColor: thomePageBackgroundColor,
    body: Column(
      children: [
        Row(
          children: [],
        ),
      ],
    ),
   );
   }
}


//  return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.menu, color: Colors.black),
//         title: Text(tSignUpTitle , style: Theme.of(context).textTheme.headlineSmall),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         actions: [
//           Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: tCardBgColor),
//               child: IconButton(onPressed: (){}, icon: const Image(image: AssetImage(tProfileImage)),),
//             ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(tDashboardPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30.0),
//                Positioned(
//                 left: 188,
//                 top: 67,
//                 child: Container(
//                   width: 105,
//                   height: 16,
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                   child: const Text(
//                     'tPower',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                       letterSpacing: 0.013,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               //   decoration: BoxDecoration(
//               //   color: Color(0xFFF2F2F3),
//               //   border: Border.all(
//               //     color: Color(0xFFE3E3E7),
//               //     width: 0.8,
//               //   ),
//               //   borderRadius: BorderRadius.circular(72),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );