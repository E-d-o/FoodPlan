import 'package:foodplan/properties/enums/single_list_property.dart';
import 'package:hive/hive.dart';

part 'single_list_properties.g.dart';

@HiveType(typeId: 1)
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
    this.imagePath,
  });
  @HiveField(0)
  bool isChecked;
  @HiveField(1)
  String title;
  @HiveField(2)
  String? subtitle; //
  @HiveField(3)
  double? price; //
  @HiveField(4)
  String? priceMeasurementUnit; //
  @HiveField(5)
  int? quantityValue; //
  @HiveField(6)
  String? quantityMeasurementUnit; //

  //are optional
  @HiveField(7)
  bool isBeingEdited;
  @HiveField(8)
  String? category; //
  @HiveField(9)
  DateTime? expireDate; //
  @HiveField(10)
  String? imagePath; //

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
      imagePath: imagePath,
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
          if (value == null) {
            price = value;
          } else {
            throw UnimplementedError();
          }
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
      case SingleListProperty.imagePath:
        if (value is String?) {
          imagePath = value;
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
      case SingleListProperty.imagePath:
        return imagePath;
    }
  }
}
