// ignore_for_file: file_names

import '/exports/exports.dart';

class AmountController extends Cubit<double> {
  AmountController() : super(0);
  void setAmount() {
    FirebaseFirestore.instance.collection("tenants").get().then((value) {
      double total = 0;
      for (var element in value.docs) {
        
          total += double.parse(element.data()['amountPaid']);
        
        emit(total);
      }
    });
  }
}
