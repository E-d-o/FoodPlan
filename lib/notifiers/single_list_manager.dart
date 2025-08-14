import 'package:flutter/widgets.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SingleListManager with ChangeNotifier {
  final List<ListItem> requiredItemsList = [
    ListItem(id: "1", isAtHome: false),
    ListItem(id: "2", isAtHome: false),
  ];
  final List<ListItem> homeItemsList = [ListItem(id: "3", isAtHome: true)];
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
    //TODO:FIX THIS
    String newid = uuid.v4();
    requiredItemsList.add(ListItem(id: newid, isAtHome: true));
    _listChecked[newid] = false;

    notifyListeners();
  }

  void removeItem(String listId, bool isAtHome) {
    if (isAtHome) {
      print(homeItemsList.toString() + "prima");
      homeItemsList.removeWhere((element) => element.id == listId);
      print(homeItemsList.toString() + "dopo");
    } else {
      //in required items
      print(requiredItemsList);

      requiredItemsList.removeWhere((element) => element.id == listId);
      print(requiredItemsList);
    }
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
