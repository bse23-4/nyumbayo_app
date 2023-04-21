import '../exports/exports.dart';

class CommonAppbarView extends StatelessWidget {
  final double? topPadding;
  final Widget? backWidget;
  final Widget? headerWidget;
  final String titleText;
  final double titleTextSize;
  final VoidCallback? onBackClick;
  final EdgeInsets titlePadding;
  final IconData? iconData;
  final FontWeight? fontWeight;
  final Color? color;
  const CommonAppbarView({
    Key? key,
    this.topPadding,
    this.titlePadding = const EdgeInsets.all(10),
    this.titleTextSize = 24,
    this.onBackClick,
    this.headerWidget,
    this.fontWeight,
    this.color,
    this.titleText = '',
    this.backWidget,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0),
            child: headerWidget ??
                SizedBox(
                  height: AppBar().preferredSize.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 3, right: 8),
                    child: SizedBox(
                      width: AppBar().preferredSize.height - 8,
                      height: AppBar().preferredSize.height - 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: onBackClick,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: backWidget ??
                                Icon(
                                  iconData,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : color ?? Colors.black,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
          Padding(
            padding: titlePadding,
            child: Text(
              titleText,
              style: TextStyles(context).getTitleStyle().copyWith(
                  fontSize: titleTextSize,
                  color: color,
                  fontWeight: fontWeight),
            ),
          ),
        ],
      ),
    );
  }
}
