import 'package:foodplan/myclasses/list_property.dart';

class ListProperties {
  ListProperties({required this.isChecked, required this.isEditing});

  bool isChecked;
  bool isEditing;

  void setProperty(ListProperty property, dynamic value) {
    switch (property) {
      case ListProperty.isChecked:
        if (value is bool) {
          isChecked = value;
        }
      case ListProperty.isEditing:
        if (value is bool) {
          isEditing = value;
        }
    }
  }

  dynamic getProperty(ListProperty property) {
    switch (property) {
      case ListProperty.isChecked:
        return isChecked;
      case ListProperty.isEditing:
        return isEditing;
    }
  }
}
