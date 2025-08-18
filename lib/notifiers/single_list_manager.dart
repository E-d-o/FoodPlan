import 'package:flutter/material.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:foodplan/notifiers/editable.dart';
import 'package:foodplan/properties/single_list_properties.dart';
import 'package:foodplan/properties/single_list_property.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SingleListManager extends Editable {
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
        isBeingEdited: true,
        category: "Salumi",
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

  void setProperty<T>(String listId, SingleListProperty property, T value) {
    if (_isSafeToAccessProperty(listId, property)) {
      _properties[listId]!.setProperty(property, value);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic getProperty(String listId, SingleListProperty property) {
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
    return getProperty(listId, SingleListProperty.isChecked);
  }

  void _addProperty(String listId, String title) {
    _properties[listId] = SingleListProperties(
      isChecked: false,
      title: title,
      isBeingEdited: true,
    );
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
    setProperty<bool>(listId, SingleListProperty.isChecked, !isAtHome);
  }

  void removeItem(String listId) {
    if (getProperty(listId, SingleListProperty.isChecked)) {
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
    bool isAtHome = getProperty(listId, SingleListProperty.isChecked);

    _changeToOtherList(listId, isAtHome);
    _checkForEmptyHomeItems();
    notifyListeners();
  }

  @override // since title is always editable will always return true
  bool getEditStatus(String id) {
    return getProperty(id, SingleListProperty.isBeingEdited);
  }

  void _addNewTitle(String listId, String newTitle) {
    setProperty<String>(listId, SingleListProperty.title, newTitle);
  }

  @override
  void changeEditState(String listId) {
    //title is always editable, editState is always true and we dont need to change it

    notifyListeners();
  }

  void saveCategory(String id, String category) {
    setProperty<String>(id, SingleListProperty.category, category);
  }

  void savePrice(String id, String priceString) {
    double? priceDouble = double.tryParse(priceString);
    setProperty<double?>(id, SingleListProperty.price, priceDouble);
    notifyListeners();
  }

  void saveSubtitle(String id, String subtitle) {
    setProperty<String?>(id, SingleListProperty.subtitle, subtitle);
    notifyListeners();
  }

  void saveDate(
    String id,
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? oldDate = getProperty(id, SingleListProperty.expireDate);

    setProperty<DateTime?>(id, SingleListProperty.expireDate, oldDate);
    DateTime? newDate = getProperty(id, SingleListProperty.expireDate);

    controller.text = '${newDate!.day}/${newDate.month}/${newDate.year}';
    notifyListeners();
  }

  void saveQuantity(String id, String quantityString) {
    int? newValue = int.tryParse(quantityString);
    setProperty<int?>(id, SingleListProperty.quantityValue, newValue);
    notifyListeners();
  }

  @override
  void renameItem(String renameId, String newTitle) {
    changeEditState(renameId);
    _addNewTitle(renameId, newTitle);
    notifyListeners();
  }

  @override
  String getTitle(String listId) {
    return getProperty(listId, SingleListProperty.title);
  }
}
