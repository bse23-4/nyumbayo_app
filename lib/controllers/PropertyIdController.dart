import '/exports/exports.dart';
class PropertyIdController extends Cubit<String> {
  PropertyIdController() : super("Select a property");

    //  FirebaseFirestore.instance.collection("properties").get()
  void setPropertyId(String id) {
    SharedPreferences.getInstance().then((value) {
      value.setString("propertyId", id);
    });
    emit(id);
  }
  // get property
  void getPropertyId(){
    SharedPreferences.getInstance().then((value) {
       emit(value.getString("propertyId") ?? "");
    });
  }

}