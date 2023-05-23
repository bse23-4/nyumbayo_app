import '/exports/exports.dart';
class TenantController extends Cubit<Map<String, dynamic>>{
  TenantController() : super({});
  void fetchTenants(String tenantId){
    FirebaseFirestore.instance.collection("tenants").doc(tenantId).get().then((value) {
      print(tenantId);
      emit(value.data() ?? {});
    });
  }
}