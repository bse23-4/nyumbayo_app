import '/exports/exports.dart';

class SearchField extends StatelessWidget {
  SearchField({
    this.onSearch,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        hintText: hintText ?? "search..",
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (onSearch != null) onSearch!(controller.text);
      },
      textInputAction: TextInputAction.search,
      // style: TextStyle(color: kFontColorPallets[1]),
    );
  }
}
