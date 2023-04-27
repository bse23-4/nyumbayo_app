
import 'package:flutter/material.dart';
import 'package:nyumbayo_app/utils/theme.dart';
//import 'package:nyumbayo_app/views/Auth/on_boarding_screen.dart';
// import 'package:nyumbayo_app/constants/image.dart';
// import 'package:nyumbayo_app/constants/text_strings.dart';
// import 'package:nyumbayo_app/constants/sizes.dart';
import 'package:nyumbayo_app/views/Auth/splash_screen.dart';
import 'package:get/get.dart';
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
      themeMode: ThemeMode.light,
      home:  SplashScreen(),
    );
  }
}






