import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

class SettingsManager extends ChangeNotifier {
  static const String _boxName = 'settings';
  late Box _settingsBox;

  // used in box as keys
  static const String _priceMeasurementUnitKey = "priceMeasurementUnit";

  // static const String _languageKey = 'language';
  //  static const String _openLastListKey = 'openLastList';
  static const List<String> availablePriceUnits = ['€', '\$', '£', '¥'];
  final String _defaultPriceMeasurementUnit = '€';
  String get priceMeasurementUnit => _settingsBox.get(_priceMeasurementUnitKey);

  // String _defaultLanguage = 'Italiano';
  //  bool _defaultOpenLastList = false;
  SettingsManager() {
    _initSettings();
  }

  void _initSettings() async {
    _settingsBox = await Hive.openBox(_boxName);
    if (!_settingsBox.containsKey(_priceMeasurementUnitKey)) {
      await _settingsBox.put(
        _priceMeasurementUnitKey,
        _defaultPriceMeasurementUnit,
      );
    }
    notifyListeners();
  }

  void setPriceMeasurementUnit(String measurementUnit) async {
    await _settingsBox.put(_priceMeasurementUnitKey, measurementUnit);
    notifyListeners();
  }
}
