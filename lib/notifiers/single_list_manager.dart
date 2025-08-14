import 'package:flutter/widgets.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SingleListManager with ChangeNotifier {
  final List<ListItem> requiredItemsList = [
    ListItem(id: "ciccio"),
    ListItem(id: "ciccio"),
  ];
  final List<ListItem> homeItemsList = [ListItem(id: "ciccio")];
  late final List<List<ListItem>> completeList;
  bool _isHomeItemsVisible = true;

  bool get isHomeItemsVisible => _isHomeItemsVisible;
  final Map<String, bool> _listChecked = {};

  SingleListManager() {
    completeList = [requiredItemsList, homeItemsList];
    _listChecked["ciccio"] = false;
  }

  void changeHomeItemsVisibility() {
    _isHomeItemsVisible = !isHomeItemsVisible;
    notifyListeners();
  }

  bool getCheckedValue(String listId) {
    if (_listChecked[listId] == null) {
      return false;
    } else {
      return _listChecked[listId]!;
    }
  }

  void addNewItem() {
    String newid = uuid.v4();
    requiredItemsList.add(ListItem(id: newid));
    _listChecked[newid] = false;

    notifyListeners();
  }

  void changeCheckedValue(String listId) {
    if (_listChecked[listId] != null) {
      _listChecked[listId] = !_listChecked[listId]!;
    } else {
      throw Exception("checking list: value in map is null");
    }

    notifyListeners();
  }
}
