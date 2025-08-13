import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';

class MainListManager with ChangeNotifier {
  final List<MainList> _mainListPages = [MainList(listIndex: 0)];
  List<MainList> get mainListPages => _mainListPages;

  void addMainList() {
    _mainListPages.insert(
      _mainListPages.length,
      MainList(listIndex: _mainListPages.length),
    );

    notifyListeners();
  }

  void removeMainList(int index) {
    mainListPages.removeAt(
      index,
    ); //TODO: FIX INDEX , IMPLEMENT REMOVAL WITHOUT HAVING TO REFRESH INDEXVALUES

    notifyListeners();
  }
}
