import 'package:flutter/material.dart';

import 'package:foodplan/components/mainlist.dart';
import 'package:foodplan/myclasses/main_list_properties.dart';
import 'package:foodplan/myclasses/main_list_property.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class MainListManager with ChangeNotifier {
  final List<MainList> _mainListPages = [MainList(id: uuid.v4())];
  List<MainList> get mainListPages => _mainListPages;
  String _selectedId = "";
  bool _isEditingList = false;
  String defaultTitle = "Nuova Lista";
  final Map<String, MainListProperties> _mainListProperties = {};

  set selectedId(String myId) {
    if (myId.isNotEmpty) {
      _selectedId = myId;
    } else {
      throw ArgumentError("The id given is empty");
    }
  }

  MainListManager() {
    _initProperties();
  }

  void _initProperties() {
    for (int i = 0; i < mainListPages.length; i++) {
      _mainListProperties[_mainListPages[i].id] = MainListProperties(
        title: defaultTitle,
      );
    }
  }

  String get selectedId => _selectedId;
  bool get isEditingList => _isEditingList;

  bool _isListInProperties(String listId) {
    if (_mainListProperties.containsKey(listId)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPropertyInProperties(String listId, MainListProperty property) {
    //assumes listId is in properties
    return _mainListProperties[listId]!.hasProperty(property);
  }

  bool _isSafeToAccessProperty(String listId, MainListProperty property) {
    if (_isListInProperties(listId)) {
      if (_isPropertyInProperties(listId, property)) {
        return true;
      } else {
        throw ArgumentError("property given is not in properties");
      }
    } else {
      throw ArgumentError("id is not in properties");
    }
  }

  void _setProperty(String listId, MainListProperty property, dynamic value) {
    if (_isSafeToAccessProperty(listId, property)) {
      _mainListProperties[listId]!.setProperty(property, value);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic _getProperty(String listId, MainListProperty property) {
    if (_isSafeToAccessProperty(listId, property)) {
      return _mainListProperties[listId]!.getProperty(property);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  void changeEditState() {
    _isEditingList = !isEditingList;
    notifyListeners();
  }

  String getListTitle(String listId) {
    return _getProperty(listId, MainListProperty.title);
  }

  void _addNewTitle(String listId, String newTitle) {
    _setProperty(listId, MainListProperty.title, newTitle);
  }

  void _removeProperties(String listId) {
    _mainListProperties.remove(listId);
  }

  void _addProperties(String listId) {
    _mainListProperties[listId] = MainListProperties(title: defaultTitle);
  }

  void addMainList() {
    String generatedId = uuid.v4();

    _mainListPages.insert(
      //inserisco nella lista
      _mainListPages.length,
      MainList(id: generatedId, givenTitle: defaultTitle),
    );
    _addProperties(
      generatedId,
    ); //aggiungo le proprieta' relative alla lista alla mappa (un nuovo oggetto MainListProperties)

    notifyListeners();
  }

  void removeMainList(String removeId) {
    _mainListPages.removeWhere((mainlist) => mainlist.id == removeId);
    _removeProperties(removeId);
    notifyListeners();
  }

  void renameList(String renameId, String newTitle) {
    changeEditState();
    _addNewTitle(renameId, newTitle);
    notifyListeners();
  }
}
