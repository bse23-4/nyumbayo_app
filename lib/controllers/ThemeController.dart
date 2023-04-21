import '/exports/exports.dart';

class ThemeController extends Cubit<ThemeData> {
  ThemeController() : super(ThemeData.light());
  void changeTheme(ThemeData theme) {
    emit(theme);
  }
}