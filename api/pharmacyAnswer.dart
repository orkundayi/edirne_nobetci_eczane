import 'package:edirne_nobetci_eczaneler/api/pharmacy.dart';

class PharmacyAnswer {
  bool success;
  // ignore: non_constant_identifier_names
  List<Pharmacy> PharmacyList;

  PharmacyAnswer(this.success, this.PharmacyList);

  factory PharmacyAnswer.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["result"] as List;
    List<Pharmacy> pharmacyList = jsonArray
        .map((jsonArrayObject) => Pharmacy.fromJson(jsonArrayObject))
        .toList();
    return PharmacyAnswer(json["success"] as bool, pharmacyList);
  }
}
