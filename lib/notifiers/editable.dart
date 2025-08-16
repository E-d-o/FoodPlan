import 'package:flutter/material.dart';

abstract class Editable extends ChangeNotifier {
  bool getEditStatus(String id);
  String getTitle(String listId);
  void renameItem(String renameId, String newTitle);
  void changeEditState(String listId);
}
