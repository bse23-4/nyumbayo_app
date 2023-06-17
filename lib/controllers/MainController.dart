import '/exports/exports.dart';

class MainController extends ChangeNotifier{
  // variables
  List<Map<String,dynamic>> _complaints = [];
  List<Map<String,dynamic>> get complaints => _complaints;

  // functions
  void setComplaints(){
    Database.fetchAll("complaints").then((event) {
      _complaints = event;
      notifyListeners();
    });
  }
}