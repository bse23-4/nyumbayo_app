// ignore_for_file: file_names

import '/exports/exports.dart';

class AmountController extends Cubit<double> {
  AmountController() : super(0);
  void tenantAmounPaid(String id) {
    FirebaseFirestore.instance.collection("tenants").doc(id).get().then((value) {
      value.data()?["amountPaid"] == null
          ? emit(0)
          : emit(double.parse(value.data()?["amountPaid"]));
    });
  }
}
