import 'package:foodplan/properties/main_list_property.dart';

class MainListProperties {
  MainListProperties({
    required this.title,
    required this.progress,
    required this.isBeingEdited,
  });

  String title;
  double progress;
  bool isBeingEdited;
  bool hasProperty(MainListProperty property) {
    return true; //add logic here if you want to check that you wrote all of the mainListProperties specified in the enum MainLIstProperty
  }

  void setProperty(MainListProperty property, dynamic value) {
    switch (property) {
      case MainListProperty.title:
        if (value is String) {
          title = value;
        } else {
          throw ArgumentError("title non e' una string");
        }
      case MainListProperty.progress:
        if (value is double) {
          progress = value;
        } else {
          throw ArgumentError("progress non e' un double");
        }
      case MainListProperty.isBeingEdited:
        if (value is bool) {
          isBeingEdited = value;
        } else {
          throw ArgumentError("isbeingEdited non e' un bool");
        }
      // ignore: unreachable_switch_default
      default:
        throw ArgumentError(
          "Ti sei dimenticato di inserire una Mainlistproperty nello switch ",
        );
    }
  }

  dynamic getProperty(MainListProperty property) {
    switch (property) {
      case MainListProperty.title:
        return title;
      case MainListProperty.progress:
        return progress;
      case MainListProperty.isBeingEdited:
        return isBeingEdited;
      // ignore: unreachable_switch_default
      default:
        throw ArgumentError(
          "Ti sei dimenticato di inserire una Mainlistproperty nello switch ",
        );
    }
  }
}
