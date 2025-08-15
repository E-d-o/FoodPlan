import 'package:flutter/widgets.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:foodplan/properties/single_list_properties.dart';
import 'package:foodplan/properties/single_list_property.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SingleListManager with ChangeNotifier {
  final List<ListItem> requiredItemsList = [
    ListItem(id: "1"),
    ListItem(id: "2"),
  ];
  final List<ListItem> homeItemsList = [ListItem(id: "3")];

  bool _isHomeItemsVisible = true;
  double _paddingHomeItems = 16.0;

  bool get isHomeItemsVisible => _isHomeItemsVisible;
  double get paddingHomeItems => _paddingHomeItems;

  final Map<String, SingleListProperties> _properties = {};
  SingleListManager() {
    _initProperties();
  }

  void _initProperties() {
    _initItems(requiredItemsList);
    _initItems(homeItemsList);
  }

  void _initItems(List<ListItem> list) {
    for (int i = 0; i < list.length; i++) {
      _properties[list[i].id] = SingleListProperties(
        isChecked: false,
        isAtHome: false,
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

  bool _isPropertyInProperties(String listId, SingleListProperty property) {
    //to ensure that the property exists
    return true;
  }

  bool _isSafeToAccessProperty(String listId, SingleListProperty property) {
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

  void _setProperty(String listId, SingleListProperty property, dynamic value) {
    if (_isSafeToAccessProperty(listId, property)) {
      _properties[listId]!.setProperty(property, value);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic _getProperty(String listId, SingleListProperty property) {
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
    return _getProperty(listId, SingleListProperty.isChecked);
  }

  void _addProperty(String listId) {
    _properties[listId] = SingleListProperties(
      isChecked: false,
      isAtHome: false,
    );
  }

  void addNewItem() {
    String newid = uuid.v4();
    requiredItemsList.add(ListItem(id: newid));
    _addProperty(newid);

    notifyListeners();
  }

  void _removeProperty(String listId) {
    _properties.remove(listId);
  }

  void removeItem(String listId) {
    if (_getProperty(listId, SingleListProperty.isAtHome)) {
      homeItemsList.removeWhere((element) => element.id == listId);
      _checkForEmptyHomeItems();
    } else {
      //in required items

      requiredItemsList.removeWhere((element) => element.id == listId);
    }
    _removeProperty(listId);
    notifyListeners();
  }

  void changeCheckedValue(String listId) {
    bool newvalue = !_getProperty(listId, SingleListProperty.isChecked);
    _setProperty(listId, SingleListProperty.isChecked, newvalue);

    notifyListeners();
  }
}
