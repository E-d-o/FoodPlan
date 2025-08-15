import 'package:foodplan/myclasses/main_list_property.dart';

class MainListProperties {
  MainListProperties({required this.title});

  String title;

  bool hasProperty(MainListProperty property) {
    switch (property) {
      case MainListProperty.title:
        return true;
      default:
        return false;
    }
  }

  void setProperty(MainListProperty property, dynamic value) {
    switch (property) {
      case MainListProperty.title:
        if (value is String) {
          title = value;
        }
      default:
        print("sbagliato set property");
    }
  }

  dynamic getProperty(MainListProperty property) {
    switch (property) {
      case MainListProperty.title:
        return title;
      default:
        print("sbagliato get property");
    }
  }
}
