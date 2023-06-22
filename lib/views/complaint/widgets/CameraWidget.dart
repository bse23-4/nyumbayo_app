import '/exports/exports.dart';

class CameraWidget extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final IconData icon;
  const CameraWidget({super.key, required this.onClick, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          child: TapEffect(
            child: Icon(icon, size: 40),
            onClick: onClick,
          ),
        ),
        Text(
          title,
          style: TextStyles(context).getRegularStyle(),
        ),
      ],
    );
  }
}
