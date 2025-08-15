import 'package:foodplan/myclasses/list_property.dart';

class ListProperties {
  ListProperties({required this.isChecked, required this.isAtHome});

  bool isChecked;
  bool isAtHome;

  void setProperty(ListProperty property, dynamic value) {
    switch (property) {
      case ListProperty.isChecked:
        if (value is bool) {
          isChecked = value;
        }
      case ListProperty.isAtHome:
        if (value is bool) {
          isAtHome = value;
        }
    }
  }

  dynamic getProperty(ListProperty property) {
    switch (property) {
      case ListProperty.isChecked:
        return isChecked;
      case ListProperty.isAtHome:
        return isAtHome;
    }
  }
}
