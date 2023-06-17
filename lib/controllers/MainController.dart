import '/exports/exports.dart';

class MainController extends ChangeNotifier{
  // variables
  List<Map<String,dynamic>> _complaints = [];
  List<Map<String,dynamic>> get complaints => _complaints;

  // functions
  void fetchComplaints(String id){
    FirebaseFirestore.instance.collection("complaints").snapshots().listen((event) {
      _complaints = event.docs.where((element) => element.data()["property_id"] == id).map((e) => e.data()).toList();
      notifyListeners();
    });
  }
}