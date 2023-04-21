import '/exports/exports.dart';

class CommonDropDown extends StatelessWidget {
  final List<DropdownMenuEntry> entries;
  final String? hintText;
  final String? titleText;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final IconData icon;
  final void Function(dynamic)? onSelect;
  final TextEditingController? controller;
  final double radius;
  const CommonDropDown(
      {super.key,
      this.backgroundColor,
      this.padding = EdgeInsets.zero,
      this.titleText,
      this.radius = 24,
      required this.entries,
      required this.icon,
      this.controller,
      this.hintText,
      this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.21,
        height: MediaQuery.of(context).size.height * 0.11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: Text(
                titleText ?? "",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black12.withOpacity(0.6)
                      : Colors.black12.withOpacity(0.12),
                ),
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black12.withOpacity(0.6)
                  : Colors.white,
              shadowColor: Colors.black12.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.2,
              ),
              child: DropdownMenuTheme(
                data: DropdownMenuThemeData(
                  menuStyle: MenuStyle(
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(left: 24, right: 24)),
                    fixedSize: MaterialStateProperty.all(
                      Size.fromWidth(MediaQuery.of(context).size.width),
                    ),
                  ),
                ),
                child: DropdownMenu(
                  width: MediaQuery.of(context).size.width,
                  // height:MediaQuery.of(context).size.height,
                  enableSearch: true,
                  enableFilter: true,
                  hintText: hintText,
                  controller: controller,
                  onSelected: onSelect,
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: TextStyles(context).getDescriptionStyle(),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 17,
                      bottom: 12,
                      left: 10,
                      right: 10,
                    ),
                  ),
                  dropdownMenuEntries: entries,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
