import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class MainListManager with ChangeNotifier {
  final List<MainList> _mainListPages = [MainList(id: uuid.v4())];
  List<MainList> get mainListPages => _mainListPages;
  String _selectedId = "";
  bool _isEditingList = false;

  set selectedId(String myId) {
    if (myId.isNotEmpty) {
      _selectedId = myId;
    } else {
      throw ArgumentError("The id given is empty");
    }
  }

  String get selectedId => _selectedId;
  bool get isEditingList => _isEditingList;

  void changeEditState() {
    _isEditingList = !isEditingList;
    notifyListeners();
  }

  void addMainList() {
    String generatedId = uuid.v4();
    _mainListPages.insert(
      _mainListPages.length,
      MainList(id: generatedId, title: _mainListPages.length.toString()),
    );
    print(generatedId);

    notifyListeners();
  }

  void removeMainList(String removeId) {
    _mainListPages.removeWhere((mainlist) => mainlist.id == removeId);
    notifyListeners();
  }

  void renameList(String renameId, String newTitle) {
    changeEditState();
    int index = _mainListPages.indexWhere(
      (mainlist) => mainlist.id == renameId,
    );
    _mainListPages[index].title = newTitle;
    notifyListeners();
  }
}
