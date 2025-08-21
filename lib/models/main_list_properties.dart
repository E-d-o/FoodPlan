import 'package:foodplan/models/enums/main_list_property.dart';
import 'package:hive/hive.dart';
part 'main_list_properties.g.dart';

@HiveType(typeId: 0)
class MainListProperties extends HiveObject {
  MainListProperties({
    required this.title,
    required this.progress,
    required this.isBeingEdited,
    required this.timeOfAddition,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  double progress;
  @HiveField(2)
  bool isBeingEdited;

  @HiveField(3)
  DateTime timeOfAddition = DateTime(2024, 4, 30);
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
      case MainListProperty.timeOfAddition:
        if (value is DateTime) {
        } else {
          throw ArgumentError("timeOfAddition non e' un Datetime");
        }
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

      case MainListProperty.timeOfAddition:
        return timeOfAddition;
    }
  }
}
