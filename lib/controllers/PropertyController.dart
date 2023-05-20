import "/exports/exports.dart";
class PropertyController extends Cubit<List<QueryDocumentSnapshot<Map<String, dynamic>>>>{
  PropertyController() : super([]);
  void fetchProperties(){
    FirebaseFirestore.instance.collection("properties").get().then((value) {
      
      emit(value.docs);
    });
  }
}