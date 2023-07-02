import '/exports/exports.dart';

class LandlordController extends Cubit<Map<String, dynamic>> {
  LandlordController() : super(Map.from({}));
  void landLordData() {
    FirebaseFirestore.instance
        .collection("landlords")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      emit(
        value.data() ?? {},
      );
    });
  }
}
