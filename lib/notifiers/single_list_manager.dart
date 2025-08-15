import 'package:flutter/widgets.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:foodplan/myclasses/list_properties.dart';
import 'package:foodplan/myclasses/list_property.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SingleListManager with ChangeNotifier {
  final List<ListItem> requiredItemsList = [
    ListItem(id: "1", isAtHome: false),
    ListItem(id: "2", isAtHome: false),
  ];
  final List<ListItem> homeItemsList = [ListItem(id: "3", isAtHome: true)];

  bool _isHomeItemsVisible = true;
  double _paddingHomeItems = 16.0;

  bool get isHomeItemsVisible => _isHomeItemsVisible;
  double get paddingHomeItems => _paddingHomeItems;

  final Map<String, ListProperties> _properties = {};

  SingleListManager() {
    _initProperties();
  }

  void _initProperties() {
    _initItems(requiredItemsList);
    _initItems(homeItemsList);
  }

  void _initItems(List<ListItem> list) {
    for (int i = 0; i < list.length; i++) {
      _properties[list[i].id] = ListProperties(
        isChecked: false,
        isEditing: false,
      );
    }
  }

  bool _isListInProperties(String listId) {
    if (_properties.containsKey(listId)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPropertyInProperties(String listId, ListProperty property) {
    switch (property) {
      case ListProperty.isChecked:
        return true;
      default:
        return false;
    }
  }

  bool _isSafeToAccessProperty(String listId, ListProperty property) {
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

  void _setProperty(String listId, ListProperty property, dynamic value) {
    if (_isSafeToAccessProperty(listId, property)) {
      _properties[listId]!.setProperty(property, value);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic _getProperty(String listId, ListProperty property) {
    if (_isSafeToAccessProperty(listId, property)) {
      return _properties[listId]!.getProperty(property);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  void _checkForEmptyHomeItems() {
    if (homeItemsList.isEmpty) {
      _paddingHomeItems = 0;
    } else {
      _paddingHomeItems = 16;
    }
  }

  void changeHomeItemsVisibility() {
    _isHomeItemsVisible = !isHomeItemsVisible;
    notifyListeners();
  }

  bool getCheckedValue(String listId) {
    return _getProperty(listId, ListProperty.isChecked);
  }

  void addNewItem() {
    //TODO:FIX THIS
    String newid = uuid.v4();
    requiredItemsList.add(ListItem(id: newid, isAtHome: true));
    _setProperty(newid, ListProperty.isChecked, false);

    notifyListeners();
  }

  void removeItem(String listId, bool isAtHome) {
    if (isAtHome) {
      homeItemsList.removeWhere((element) => element.id == listId);
      _checkForEmptyHomeItems();
    } else {
      //in required items

      requiredItemsList.removeWhere((element) => element.id == listId);
    }
    notifyListeners();
  }

  void changeCheckedValue(String listId) {
    bool newvalue = !_getProperty(listId, ListProperty.isChecked);
    _setProperty(listId, ListProperty.isChecked, newvalue);

    notifyListeners();
  }
}
