import 'package:foodplan/properties/single_list_property.dart';

class SingleListProperties {
  SingleListProperties({
    required this.isChecked,

    required this.title,
    this.subtitle,
    this.price,
    this.priceMeasurementUnit,
    this.quantityValue,
    this.quantityMeasurementUnit,
  });

  bool isChecked;

  String title;
  String? subtitle; //
  double? price; //
  String? priceMeasurementUnit; //
  int? quantityValue; //
  String? quantityMeasurementUnit; //
  //are optional

  void setProperty(SingleListProperty property, dynamic value) {
    switch (property) {
      case SingleListProperty.isChecked:
        if (value is bool) {
          isChecked = value;
        } else {
          throw UnimplementedError();
        }

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
    }
  }
}
