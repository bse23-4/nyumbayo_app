import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:line_awesome_icons/line_awesome_icons.dart';
//import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:nyumbayo_app/constants/colors.dart';


class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = false,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress ;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark? tPrimaryColor: tAccentColor;
    return ListTile(
      onTap: onPress,
      leading: Container(
        width:30,
        height:30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
         child:  Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
      trailing: endIcon? Container(
        width:30,
        height:30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(Icons.arrow_right, color: Colors.grey, size: 18),
      ) : null,
    );
  }
}