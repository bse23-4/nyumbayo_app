import '/exports/exports.dart';

class DashTile extends StatelessWidget {
  final String title;
  final String value;
  const DashTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            title,
            style: TextStyles(context).getRegularStyle().copyWith(
                fontWeight: FontWeight.w400, color: Colors.white, fontSize: 20),
          ),
        ),
      const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            value,
            style: TextStyles(context).getRegularStyle().copyWith(
                fontWeight: FontWeight.w400, color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
