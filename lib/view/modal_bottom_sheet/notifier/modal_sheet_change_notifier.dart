import 'package:flutter/material.dart';

class ModalSheetChangeNotifier extends ChangeNotifier {
  String tonnage = 'cl';

  void setTonnage(String mertek) {
    tonnage = mertek;
    notifyListeners();
  }

  final exactTonnage = [];

  void addExactTonnage(String tonnage) {
    exactTonnage.add(tonnage);

    notifyListeners();
  }

  final exactPrice = [];

  void addExactPrice(String price) {
    exactPrice.add(price);
    notifyListeners();
  }

  void delete(int index) {
    exactTonnage.removeAt(index);
    exactPrice.removeAt(index);
    notifyListeners();
  }

  void clearList() {
    exactTonnage.clear();
    exactPrice.clear();

    notifyListeners();
  }
}
