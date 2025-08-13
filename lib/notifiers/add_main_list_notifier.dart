import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';

class AddMainListNotifier with ChangeNotifier {
  List<Widget> mainListPages = [MainList()];

  void addMainList() {
    mainListPages.insert(mainListPages.length, MainList());
    notifyListeners();
  }
}
