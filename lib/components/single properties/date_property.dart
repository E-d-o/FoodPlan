import 'package:flutter/material.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';

class DateProperty extends StatelessWidget {
  const DateProperty({
    super.key,
    required this.property5,
    required this.controller,
    required this.singleListManager,
    required this.id,
  });

  final String property5;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: property5,
      widget: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        readOnly: true,
        onTap: () async {
          singleListManager.saveDate(
            id,
            context,
            controller!,
            isPermanent: false,
          );
        },
      ),
    );
  }
}
