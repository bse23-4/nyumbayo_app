// ignore_for_file: file_names

import '/exports/exports.dart';

class AmountController extends Cubit<double> {
  AmountController() : super(0);
  void setAmount(String id) {
    FirebaseFirestore.instance.collection("tenants").where("property",isEqualTo: id).get().then((value) {
      double total = 0;
      for (var element in value.docs) {
        
          total += (double.parse(element.data()['amountPaid']) + double.parse(element.data()['power_fee']));
        emit(total);
      }
    });
  }
}
