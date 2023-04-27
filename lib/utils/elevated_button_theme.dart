import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class TElevatedButtonTheme{
  TElevatedButtonTheme._(); // To avoid creating instances

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
       style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          foregroundColor: tWhiteColor,
          backgroundColor: tSecondaryColor,
          side: const BorderSide(color: tSecondaryColor),
          padding:const EdgeInsets.symmetric(vertical: tButtonHeight ),
        ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
     style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          foregroundColor: tSecondaryColor,
          backgroundColor: tWhiteColor,
          side: const BorderSide(color: tSecondaryColor),
          padding:const EdgeInsets.symmetric(vertical: tButtonHeight ),
        ),
  );
}

