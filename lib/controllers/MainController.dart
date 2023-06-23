// ignore_for_file: non_constant_identifier_names

import '../tools/index.dart';
import '/exports/exports.dart';

class MainController extends ChangeNotifier{
  // variables
  List<Map<String,dynamic>> _complaints = [];
  List<Map<String,dynamic>> _resolved_complaints = [];
 
 
  // getters
  List<Map<String,dynamic>> get complaints => _complaints;
  // tenant_id's Variable(
  String _tenantId = "";
// double
double _amt = 0;
// get amount 
double get amt => _amt;
  // get tenant id
  String get tenantId => _tenantId;
  List<Map<String,dynamic>> get resolved_complaints => _resolved_complaints;
  // functions
  void fetchComplaints(String id){
    FirebaseFirestore.instance.collection("complaints").snapshots().listen((event) {
      _complaints = event.docs.where((element) => (element.data()["property_id"] == id) && element.data()["status"] != 'Resolved').map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  void fetchResolvedComplaints(String id){
    FirebaseFirestore.instance.collection("complaints").snapshots().listen((event) {
      _resolved_complaints = event.docs.where((element) => (element.data()["property_id"] == id) && element.data()["status"] == 'Resolved').map((e) => e.data()).toList();
      notifyListeners();
    });
  }

    void setAmount(String id) {
    FirebaseFirestore.instance.collection("tenants").where("property",isEqualTo: id).get().then((value) {
      double total = 0;
      for (var element in value.docs) {
          total += (double.parse(element.data()['amountPaid']) + double.parse(element.data()['power_fee']));
      }
      _amt = total;
      notifyListeners();
    });
  }
  void captureTenantId(String id){
      _tenantId = id;
      notifyListeners();
  }

  // function to listen to new complaints from firestore and  trigger a notification
  void listenToNewComplaints(){
    int notifyOnce = 0;
    FirebaseFirestore.instance.collection("complaints").snapshots().listen((event) {
      var newComplaints = event.docs.where((element) => element.data()["accessKey"] == '0').map((e) => e.data()).toList();
      if(newComplaints.isNotEmpty && notifyOnce == 0){
        notifyOnce = 1;
        // trigger a notification showing who sent it
        sendNotification(body: "${newComplaints[newComplaints.length -1]['title']}", title: 'New Complaint', notification_id: 1);
        Future.delayed(const Duration(seconds:5),(){
          FirebaseFirestore.instance.collection("complaints").doc(newComplaints[newComplaints.length -1]['tenant_id']).update({
            'accessKey': '1',
          });
        });
      }
      notifyListeners();
    });
  }
}

