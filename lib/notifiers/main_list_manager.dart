import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class MainListManager with ChangeNotifier {
  final List<MainList> _mainListPages = [MainList(id: uuid.v4())];
  List<MainList> get mainListPages => _mainListPages;
  String _selectedId = "";
  bool _isEditingList = false;
  String defaultTitle = "Nuova Lista";
  final Map<String, String> _listTitles = {};

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

  String getListTitle(String listId) {
    return _listTitles[listId] ?? defaultTitle;
  }

  void _addNewTitle(String listId, String newTitle) {
    _listTitles[listId] = newTitle;
  }

  void _removeTitle(String listId) {
    _listTitles.remove(listId);
  }

  void addMainList() {
    String generatedId = uuid.v4();
    String givenTitle = _mainListPages.length.toString();
    _mainListPages.insert(
      _mainListPages.length,
      MainList(id: generatedId, givenTitle: givenTitle),
    );
    _addNewTitle(generatedId, givenTitle);

    notifyListeners();
  }

  void removeMainList(String removeId) {
    _mainListPages.removeWhere((mainlist) => mainlist.id == removeId);
    _removeTitle(removeId);
    notifyListeners();
  }

  void renameList(String renameId, String newTitle) {
    changeEditState();
    _listTitles[renameId] = newTitle;
    notifyListeners();
  }
}
