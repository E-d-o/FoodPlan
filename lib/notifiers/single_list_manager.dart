import 'package:flutter/widgets.dart';

class SingleListManager with ChangeNotifier {
  bool _isHomeItemsVisible = true;
  bool get isHomeItemsVisible => _isHomeItemsVisible;

  void changeHomeItemsVisibility() {
    _isHomeItemsVisible = !isHomeItemsVisible;
    notifyListeners();
  }
}
