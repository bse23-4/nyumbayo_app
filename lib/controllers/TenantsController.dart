import '/exports/exports.dart';
class TenantController extends Cubit<List<QueryDocumentSnapshot<Map<String, dynamic>>>>{
  TenantController() : super([]);
  void fetchTenants(String propertyId){
    FirebaseFirestore.instance.collection("tenants").get().then((value) {
      emit(value.docs.where((element) => element.data()['property'] == propertyId).toList());
    });
  }
}