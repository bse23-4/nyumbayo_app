import '/exports/exports.dart';

class SettingCard extends StatelessWidget {
  final String titleText;
  final String subText;
  final Widget trailWidget;
  final Color? color;
  final double radius;
  final double? trailTextSize;
  final double? subTextSize;
  final double? titleTextSize;
  final String icon;
  final EdgeInsetsGeometry? padding;
  final String? trailText;
  final Widget? leading;
  final Widget? title;
  const SettingCard({
    super.key,
    required this.titleText,
    this.color,
    this.padding,
    this.title,
    this.subText = '',
    this.trailText = '',
    this.trailWidget = const SizedBox(),
    this.radius = 13,
    this.leading,
    this.trailTextSize,
    this.icon = "",
    this.subTextSize,
    this.titleTextSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: padding ??
          const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 5.0),
      elevation: 0,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: Theme.of(context).brightness == Brightness.light
          ? color ?? Color.fromRGBO(246, 246, 246, 1)
          : Theme.of(context).cardColor,
      child: ListTileTheme(
        contentPadding:
            const EdgeInsets.only(left: 3, top: 3, right: 4, bottom: 3),
        child: ListTile(
          leading: leading ??
              Image.asset(
                icon,
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.width / 8,
              ),
          trailing: trailText == null || trailText == ''
              ? trailWidget
              : Text(
                  trailText!,
                  style: TextStyles(context)
                      .getDescriptionStyle()
                      .copyWith(fontSize: trailTextSize ?? 13),
                ),
          title: title ??
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  titleText,
                  style: TextStyles(context)
                      .getBoldStyle()
                      .copyWith(fontSize: titleTextSize ?? 14.3),
                ),
              ),
          subtitle: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              subText,
              style: TextStyles(context)
                  .getDescriptionStyle()
                  .copyWith(fontSize: subTextSize ?? 12),
            ),
          ),
        ),
      ),
    );
  }
}
