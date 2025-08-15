import 'package:foodplan/properties/single_list_property.dart';

class SingleListProperties {
  SingleListProperties({required this.isChecked, required this.isAtHome});

  bool isChecked;
  bool isAtHome;

  void setProperty(SingleListProperty property, dynamic value) {
    switch (property) {
      case SingleListProperty.isChecked:
        if (value is bool) {
          isChecked = value;
        }
      case SingleListProperty.isAtHome:
        if (value is bool) {
          isAtHome = value;
        }
    }
  }

  dynamic getProperty(SingleListProperty property) {
    switch (property) {
      case SingleListProperty.isChecked:
        return isChecked;
      case SingleListProperty.isAtHome:
        return isAtHome;
    }
  }
}
