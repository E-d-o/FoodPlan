import 'package:foodplan/models/single_list_property.dart';

class SingleListProperties {
  SingleListProperties({
    required this.isChecked,

    required this.title,
    this.subtitle,
    this.price,
    this.priceMeasurementUnit,
    this.quantityValue,
    this.quantityMeasurementUnit,
    required this.isBeingEdited,
    this.category,
    this.expireDate,
  });

  bool isChecked;

  String title;
  String? subtitle; //
  double? price; //
  String? priceMeasurementUnit; //
  int? quantityValue; //
  String? quantityMeasurementUnit; //

  //are optional
  bool isBeingEdited;
  String? category; //
  DateTime? expireDate; //

  SingleListProperties copy() {
    return SingleListProperties(
      isChecked: isChecked,
      title: title,
      isBeingEdited: isBeingEdited,
      subtitle: subtitle,
      price: price,
      priceMeasurementUnit: priceMeasurementUnit,
      quantityValue: quantityValue,
      quantityMeasurementUnit: quantityMeasurementUnit,
      category: category,
      expireDate: expireDate,
    );
  }

  void setProperty(SingleListProperty property, dynamic value) {
    switch (property) {
      case SingleListProperty.isChecked:
        isChecked = value as bool;
        break;

      case SingleListProperty.title:
        if (value is String) {
          title = value;
        } else {
          throw UnimplementedError();
        }

      case SingleListProperty.subtitle:
        if (value is String) {
          subtitle = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.price:
        if (value is double) {
          price = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.priceMeasurementUnit:
        if (value is String) {
          priceMeasurementUnit = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.quantityValue:
        if (value is int) {
          quantityValue = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.quantityMeasurementUnit:
        if (value is String) {
          quantityMeasurementUnit = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.isBeingEdited:
        if (value is bool) {
          isBeingEdited = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.category:
        if (value is String) {
          category = value;
        } else {
          throw UnimplementedError();
        }
      case SingleListProperty.expireDate:
        if (value is DateTime) {
          expireDate = value;
        } else {
          throw UnimplementedError();
        }
    }
  }

  dynamic getProperty(SingleListProperty property) {
    switch (property) {
      case SingleListProperty.isChecked:
        return isChecked;

      case SingleListProperty.title:
        return title;
      case SingleListProperty.subtitle:
        return subtitle;
      case SingleListProperty.price:
        return price;
      case SingleListProperty.priceMeasurementUnit:
        return priceMeasurementUnit;
      case SingleListProperty.quantityValue:
        return quantityValue;
      case SingleListProperty.quantityMeasurementUnit:
        return quantityMeasurementUnit;
      case SingleListProperty.isBeingEdited:
        return isBeingEdited;
      case SingleListProperty.category:
        return category;
      case SingleListProperty.expireDate:
        return expireDate;
    }
  }
}
