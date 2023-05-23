
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:nyumbayo_app/utils/theme.dart';
import 'package:nyumbayo_app/views/Auth/splash_screen.dart';
import 'package:get/get.dart';
import 'package:nyumbayo_app/views/Dashboard/dashboard.dart';
import 'package:nyumbayo_app/views/complaint/Complaint_submitted.dart';
import 'package:nyumbayo_app/views/complaint/complaint.dart';
import 'package:nyumbayo_app/views/profile/profile_screen.dart';

import 'views/complaint/PiePage.dart';
//import 'package:nyumbayo_app/views/Auth/welcome.dart';

void main() => runApp(const  MyApp ());

class  MyApp  extends StatelessWidget {
  const  MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'nyumbayo',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.deepPurple),
      //darkTheme: ThemeData(brightness: Brightness.dark),
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      themeMode: ThemeMode.light,
      // ignore: prefer_const_constructors
      //home: PieChartWidget(10),
      home:  SplashScreen(),
    );
  }
}






