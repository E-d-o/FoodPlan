import 'package:flutter/material.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/models/single_list_manager.dart';
import 'package:foodplan/properties/enums/single_list_property.dart';

class DescriptionProperty extends StatelessWidget {
  const DescriptionProperty({
    super.key,
    required this.descriptionProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.fieldStyle,
  });

  final String descriptionProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final TextStyle fieldStyle;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: descriptionProperty,
      fieldHeight: 250,

      widget: TextField(
        controller: controller,
        style: fieldStyle,
        maxLength: 200,
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          String? descriptionText = controller!.text;

          singleListManager.saveProperty(
            id,
            SingleListProperty.subtitle,
            descriptionText,
            isPermanent: false,
          );
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
