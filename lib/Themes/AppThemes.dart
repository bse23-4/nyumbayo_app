// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        backgroundColor: const Color.fromARGB(204, 9, 87, 139),
        highlightColor: Colors.white,
        cardColor: Colors.grey[200],
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
      );

  // dark theme
  static ThemeData get darkTheme => ThemeData(
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
        highlightColor: Colors.blueAccent,
        brightness: Brightness.dark,
      );
}
