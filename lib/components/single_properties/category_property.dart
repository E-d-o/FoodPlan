import 'package:flutter/material.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:foodplan/models/enums/single_list_property.dart';

class CategoryProperty extends StatelessWidget {
  const CategoryProperty({
    super.key,
    required this.categoryProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.fieldStyle,
  });

  final String categoryProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final TextStyle fieldStyle;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: categoryProperty,

      widget: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: fieldStyle,
        maxLength: 26,
        onChanged: (value) {
          String? categoryText = controller!.text;
          singleListManager.saveProperty(
            id,
            SingleListProperty.category,
            categoryText,
            isPermanent: false,
          );
        },
        onTapOutside: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
