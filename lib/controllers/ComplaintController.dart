import '/exports/exports.dart';

class ComplaintsController extends Cubit<List<Map<String,dynamic>>>{
  ComplaintsController() : super([]);

  void setComplaints(){
    Database.fetchAll("complaints").then((event) {
      emit(event);
    });
  }
}