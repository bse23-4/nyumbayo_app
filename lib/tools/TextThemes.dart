import '/exports/exports.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle() {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
    // return Theme.of(context).textTheme.titleLarge!.copyWith(
    //       fontSize: 24,
    //       color: Theme.of(context).brightness == Brightness.dark
    //           ? Colors.white
    //           : Colors.black,
    //     );
    // return TextStyle();
  }

  TextStyle getDescriptionStyle() {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[300]
          : Colors.black54,
    );
    // return Theme.of(context).textTheme.bodyLarge!.copyWith(
    //       color: Theme.of(context).brightness == Brightness.dark
    //           ? Colors.grey[300]
    //           : Colors.black54,
    //     );
    // return TextStyle();
  }

  TextStyle getRegularStyle() {
    return GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.blueAccent[900],
    );
    // return Theme.of(context).textTheme.bodyLarge!.copyWith(
    //       fontSize: 16,
    //       color: Theme.of(context).brightness == Brightness.dark
    //           ? Colors.white
    //           : Colors.black,
    //     );
    // return TextStyle();
  }

  TextStyle getBoldStyle() {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
    // return Theme.of(context).textTheme.titleMedium!.copyWith(
    //       fontSize: 14,
    //       color: Theme.of(context).brightness == Brightness.dark
    //           ? Colors.white
    //           : Colors.black,
    //     );
    // return TextStyle();
  }
}
