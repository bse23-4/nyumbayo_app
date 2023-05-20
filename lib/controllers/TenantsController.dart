import '/exports/exports.dart';
class TenantController extends Cubit<List<QueryDocumentSnapshot<Map<String, dynamic>>>>{
  TenantController() : super([]);
  void fetchTenants(){
    FirebaseFirestore.instance.collection("tenants").get().then((value) {
      emit(value.docs);
    });
  }
}