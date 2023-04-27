import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class TOutlinedButtonTheme{
  TOutlinedButtonTheme._(); // To avoid creating instances

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
     style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: tSecondaryColor,
        side: const BorderSide(color: tSecondaryColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight ),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: tWhiteColor,
        side: const BorderSide(color: tWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight ),
    ),
  );
}

