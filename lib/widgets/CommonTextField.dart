import '../exports/exports.dart';

class CommonTextField extends StatelessWidget {
  final String? titleText;
  final String hintText;
  final String? errorText;
  final bool isObscureText, isAllowTopTitleView;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Color? fieldColor;
  final IconData? icon;
  final bool enableSuffix;
  final IconData? suffixIcon;
  final bool enableBorder;
  final VoidCallback? onTapSuffix;
  final String? Function(String?)? validate;
  const CommonTextField({
    Key? key,
    this.hintText = '',
    this.isObscureText = false,
    this.padding = const EdgeInsets.only(),
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isAllowTopTitleView = true,
    this.errorText,
    this.titleText = '',
    this.enableBorder = false,
    this.validate,
    this.fieldColor,
    this.controller,
    this.suffixIcon,
    this.onTapSuffix,
    this.enableSuffix = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAllowTopTitleView && titleText != '')
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: Text(
                titleText ?? "",
                style: TextStyles(context).getDescriptionStyle(),
              ),
            ),
          Card(
            elevation: 0,
            color: fieldColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: enableBorder
                  ? BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.black12,
                    )
                  : BorderSide.none,
            ),
            shadowColor: Colors.black26.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                height: 45,
                child: Center(
                  child: TextFormField(
                    controller: controller,
                    maxLines: 1,
                    onChanged: onChanged,
                    style: TextStyles(context).getRegularStyle(),
                    obscureText: isObscureText,
                    cursorColor: Theme.of(context).primaryColor,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: validate,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: enableSuffix
                          ? IconButton(
                              onPressed: onTapSuffix,
                              icon: Icon(
                                suffixIcon,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white60
                                    : Colors.black26,
                              ),
                            )
                          : null,
                      prefixIcon: Icon(icon,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white60
                              : Colors.black26),
                      errorText: null,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    keyboardType: keyboardType,
                  ),
                ),
              ),
            ),
          ),
          if (errorText != null && errorText != '')
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: Text(
                errorText ?? "",
                style: const TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            )
        ],
      ),
    );
  }
}
