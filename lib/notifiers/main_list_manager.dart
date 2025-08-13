import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';

class MainListManager with ChangeNotifier {
  final List<MainList> _mainListPages = [MainList(), MainList()];
  List<MainList> get mainListPages => _mainListPages;

  void addMainList() {
    _mainListPages.insert(_mainListPages.length, MainList());
    notifyListeners();
  }
}
