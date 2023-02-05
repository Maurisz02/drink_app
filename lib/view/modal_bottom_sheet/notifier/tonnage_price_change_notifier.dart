import 'package:flutter/material.dart';

//rossz nem hasznalom
class TonnagePriceChangeNotifier extends ChangeNotifier {
  final List<Widget> _listOfWidget = [];

  List<Widget> get listOfWidget {
    return [...listOfWidget];
  }

  void addWidget(Widget element) {
    _listOfWidget.add(element);
    notifyListeners();
  }
}
