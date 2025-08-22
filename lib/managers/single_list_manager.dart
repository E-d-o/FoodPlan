import 'package:flutter/material.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:foodplan/managers/editable.dart';

import 'package:foodplan/models/single_list_properties.dart';
import 'package:foodplan/models/enums/single_list_property.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SingleListManager extends Editable {
  final List<ListItem> requiredItemsList = [];
  final List<ListItem> homeItemsList = [];

  bool _isHomeItemsVisible = true;
  double _paddingHomeItems = 16.0;

  bool get isHomeItemsVisible => _isHomeItemsVisible;
  double get paddingHomeItems => _paddingHomeItems;

  late final Box box;

  SingleListManager({required this.box}) {
    _initProperties();
  }
  final Map<String, SingleListProperties> _tempProperties = {};

  void _initProperties() {
    if (box.isEmpty) {
      boxIsEmptyLoading();
    } else {
      boxNotEmptyLoading();
    }
  }

  void boxNotEmptyLoading() {
    homeItemsList.clear();
    requiredItemsList.clear();
    for (var key in box.keys) {
      SingleListProperties value = box.get(key);

      _tempProperties[key] = value.copy();
      if (value.isChecked) {
        //isAtHome=true
        homeItemsList.add(ListItem(id: key));
      } else {
        requiredItemsList.add(ListItem(id: key));
      }
    }
  }

  void boxIsEmptyLoading() {
    print("box is empty, adding single item");
    String newid = uuid.v4();
    ListItem firstItem = ListItem(id: newid);

    requiredItemsList.add(firstItem);
    _addProperty(newid, "banana");
  }

  bool _isListInProperties(String listId) {
    if (box.containsKey(listId)) {
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

  void setProperty(String listId, SingleListProperty property, dynamic value) {
    if (_isSafeToAccessProperty(listId, property)) {
      SingleListProperties properties = box.get(listId);
      properties.setProperty(property, value);
      box.put(listId, properties);
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  dynamic getProperty(
    String listId,
    SingleListProperty property, {
    bool isPermanent = true,
  }) {
    if (_isSafeToAccessProperty(listId, property)) {
      if (isPermanent) {
        return box.get(listId).getProperty(property);
      } else {
        return _tempProperties[listId]!.getProperty(property);
      }
    } else {
      throw ArgumentError(
        "Not safe to access, property or id is not in properties",
      );
    }
  }

  void undoChanges(String listId) {
    if (_isListInProperties(listId)) {
      for (var key in box.keys) {
        SingleListProperties value = box.get(key);
        _tempProperties[key] = value.copy();
      }
    } else {
      throw ArgumentError("no  list with such id");
    }
  }

  void checkForEmptyHomeItems() {
    if (homeItemsList.isEmpty) {
      _paddingHomeItems = 0;
    } else {
      _paddingHomeItems = 16;
    }
  }

  void changeHomeItemsVisibility() {
    _isHomeItemsVisible = !isHomeItemsVisible;
    checkForEmptyHomeItems();
    notifyListeners();
  }

  bool getCheckedValue(String listId) {
    return getProperty(listId, SingleListProperty.isChecked);
  }

  void _addProperty(String listId, String title) {
    box.put(
      listId,
      SingleListProperties(
        isChecked: false,
        title: title,
        isBeingEdited: true,
        priceMeasurementUnit: "\$",
      ),
    );

    _tempProperties[listId] = box.get(listId).copy();
  }

  void addNewItem(String title) {
    String newid = uuid.v4();
    requiredItemsList.add(ListItem(id: newid));
    _addProperty(newid, title);

    notifyListeners();
  }

  void _removeProperty(String listId) {
    box.delete(listId);
    _tempProperties.remove(listId);
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
    setProperty(listId, SingleListProperty.isChecked, !isAtHome);
  }

  void removeItem(String listId) {
    if (getProperty(listId, SingleListProperty.isChecked)) {
      //if is checked that means its at home
      homeItemsList.removeWhere((element) => element.id == listId);
      checkForEmptyHomeItems();
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
    checkForEmptyHomeItems();
    notifyListeners();
  }

  @override // since title is always editable will always return true
  bool getEditStatus(String id) {
    if (_isListInProperties(id)) {
      return getProperty(id, SingleListProperty.isBeingEdited);
    } else {
      return true;
    }
  }

  void _addNewTitle(String listId, String newTitle) {
    setProperty(listId, SingleListProperty.title, newTitle);
  }

  @override
  void changeEditState(String listId) {
    //title is always editable, editState is always true and we dont need to change it

    notifyListeners();
  }

  void saveCategory(String id, String category) {
    setProperty(id, SingleListProperty.category, category);
  }

  void savePrice(String id, String priceString, {bool isNotified = true}) {
    double? priceDouble = double.tryParse(priceString);
    setProperty(id, SingleListProperty.price, priceDouble);
    if (isNotified) {
      notifyListeners();
    }
  }

  void saveSubtitle(String id, String subtitle, {bool isNotified = true}) {
    setProperty(id, SingleListProperty.subtitle, subtitle);
    if (isNotified) {
      notifyListeners();
    }
  }

  //every property besides date
  void saveProperty(
    String id,
    SingleListProperty propertyName,
    dynamic property, {
    bool isPermanent = true,
  }) {
    if (isPermanent) {
      setProperty(id, propertyName, property);
      notifyListeners();
    } else {
      _tempProperties[id]!.setProperty(propertyName, property);
    }
  }

  void notifyChange() {
    _tempProperties.forEach((key, value) {
      box.put(key, value.copy());
    });
    notifyListeners();
  }

  void _setDate(
    String id,
    BuildContext context,
    TextEditingController controller,
    bool isPermanent,
  ) async {
    DateTime? firstAllowedDate = DateTime.now().subtract(
      Duration(days: 365 * 1),
    );
    DateTime? lastAllowedDate = DateTime(2030);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstAllowedDate,
      lastDate: lastAllowedDate,
    );

    if (pickedDate != null) {
      if (isPermanent) {
        setProperty(id, SingleListProperty.expireDate, pickedDate);
      } else {
        _tempProperties[id]!.setProperty(
          SingleListProperty.expireDate,
          pickedDate,
        );
      }

      controller.text =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    }
  }

  void saveDate(
    String id,
    BuildContext context,
    TextEditingController controller, {
    bool isPermanent = true,
  }) async {
    if (isPermanent) {
      _setDate(id, context, controller, true);
      notifyListeners();
    } else {
      _setDate(id, context, controller, false); //non e' permanent
    }
  }

  void saveQuantity(String id, String quantityString) {
    int? newValue = int.tryParse(quantityString);
    setProperty(id, SingleListProperty.quantityValue, newValue);
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
