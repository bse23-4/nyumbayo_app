import 'package:flutter/material.dart';
import 'package:nyumbayo_app/exports/exports.dart';

class ProfileMenuWidget extends StatefulWidget {
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
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    var iconColor =  Theme.of(context).primaryColor;
    return ListTile(
      onTap: widget.onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(widget.icon, color: iconColor, size: 25),
      ),
      title: Text(widget.title,
          style:
              TextStyles(context).getRegularStyle().copyWith(color: widget.textColor)),
      trailing: widget.endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child:
                  const Icon(Icons.arrow_right, color: Colors.grey, size: 18),
            )
          : null,
    );
  }
}
