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
    _initItems(requiredItemsList, false);
    _initItems(homeItemsList, true);
  }

  void _initItems(List<ListItem> list, bool isAtHome) {
    for (int i = 0; i < list.length; i++) {
      _properties[list[i].id] = SingleListProperties(
        isChecked: isAtHome,

        title: 'Cipolla',
        subtitle: "corsia 5",
        price: 2.7,
        priceMeasurementUnit: "\$",
        quantityMeasurementUnit: "g",
        quantityValue: 200,
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

  String getTitle(String listId) {
    return _getProperty(listId, SingleListProperty.title);
  }

  String? getSubtitle(String listId) {
    return _getProperty(listId, SingleListProperty.subtitle);
  }

  double? getPrice(String listId) {
    return _getProperty(listId, SingleListProperty.price);
  }

  int? getQuantity(String listId) {
    return _getProperty(listId, SingleListProperty.quantityValue);
  }

  String? getPriceMeasurementUnit(String listId) {
    return _getProperty(listId, SingleListProperty.priceMeasurementUnit);
  }

  String? getMeasurementUnit(String listId) {
    return _getProperty(listId, SingleListProperty.quantityMeasurementUnit);
  }

  void _addProperty(String listId, String title) {
    _properties[listId] = SingleListProperties(isChecked: false, title: title);
  }

  void addNewItem(String title) {
    String newid = uuid.v4();
    requiredItemsList.add(ListItem(id: newid));
    _addProperty(newid, title);

    notifyListeners();
  }

  void _removeProperty(String listId) {
    _properties.remove(listId);
  }

  void _addExistingItemToList(String listId, List<ListItem> list) {
    list.add(ListItem(id: listId));
  }

  void _removeExistingItemFromList(String listId, List<ListItem> list) {
    list.removeWhere((listItem) => listItem.id == listId);
  }

  void _changeToOtherList(String listId, bool isAtHome) {
    if (isAtHome) {
      _addExistingItemToList(listId, requiredItemsList); //add to other list
      _removeExistingItemFromList(listId, homeItemsList); //remove from old list
    } else {
      _addExistingItemToList(listId, homeItemsList);
      _removeExistingItemFromList(listId, requiredItemsList);
    }
    _setProperty(listId, SingleListProperty.isChecked, !isAtHome);
  }

  void removeItem(String listId) {
    if (_getProperty(listId, SingleListProperty.isChecked)) {
      //if is checked that means its at home
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
    bool isAtHome = _getProperty(listId, SingleListProperty.isChecked);

    _changeToOtherList(listId, isAtHome);

    notifyListeners();
  }
}
