import '/exports/exports.dart';
class PropertyIdController extends Cubit<String> {
  PropertyIdController() : super("");
  setPropertyId(String id) => emit(id);
}