import 'package:flutter/material.dart';

abstract class Editable extends ChangeNotifier {
  //MAKE MULTIPLE ABSTRACT CLASSES
  bool getEditStatus(String id);
  String getTitle(String listId); //Change in generic
  void renameItem(String renameId, String newTitle);
  void changeEditState(String listId);
}
