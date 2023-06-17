import '/exports/exports.dart';

class ComplaintsController extends Cubit<int>{
  ComplaintsController() : super(1);

  void resolveComplaintWithCondition(int time){
    Timer.periodic(Duration(seconds: time), (timer) { 
      // if(timer.tick < time){
        timer.cancel();
        emit(0);
      // }
    });
  }
}