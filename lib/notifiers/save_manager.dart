import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';

class SaveManager {
  void saveSubtitle(
    SingleListManager singleListManager,
    String id,
    String subtitle,
  ) {
    singleListManager.setSubtitle(id, subtitle);
  }

  void saveDate(
    SingleListManager singleListManager,
    String id,
    BuildContext context,
    Map<String, TextEditingController> controllerMap,
    String dateProperty,
  ) async {
    DateTime? oldDate = singleListManager.getExpireDate(id);

    await singleListManager.setDate(id, context, oldDate);
    DateTime? newDate = singleListManager.getExpireDate(id);

    controllerMap[dateProperty]!.text =
        '${newDate!.day}/${newDate.month}/${newDate.year}';
  }

  void saveQuantity(
    SingleListManager singleListManager,
    String id,
    String quantityString,
  ) {
    int? newValue = int.tryParse(quantityString);
    singleListManager.setQuantity(id, newValue);
  }

  void savePrice(
    SingleListManager singleListManager,
    String id,
    String priceString,
  ) {
    double? priceDouble = double.tryParse(priceString);
    singleListManager.setPrice(id, priceDouble);
  }

  void saveCategory(
    SingleListManager singleListManager,
    String id,
    String category,
  ) {
    singleListManager.setCategory(id, category);
  }

  void saveEverything(
    SingleListManager singleListManager,
    String id,
    BuildContext context,
    Map<String, TextEditingController> controllerMap,
    String dateProperty,
    String subtitle,
    String quantityString,
    String priceString,
    String category,
  ) {
    saveSubtitle(singleListManager, id, subtitle);
    saveDate(singleListManager, id, context, controllerMap, dateProperty);
    saveQuantity(singleListManager, id, quantityString);
    savePrice(singleListManager, id, priceString);
    saveCategory(singleListManager, id, category);
  }
}
