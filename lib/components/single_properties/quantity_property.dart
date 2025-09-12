import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/models/single_list_manager.dart';
import 'package:foodplan/properties/enums/single_list_property.dart';

class QuantityProperty extends StatelessWidget {
  QuantityProperty({
    super.key,
    required this.quantityProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.fieldStyle,
  });

  final String quantityProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final TextStyle fieldStyle;

  final List<String> measuramentUnits = ["g", "hg", "kg", "mg", "x"];

  List<DropdownMenuEntry<String>> getDropdownEntries() {
    List<DropdownMenuEntry<String>> dropdownList = [];
    for (int i = 0; i < measuramentUnits.length; i++) {
      dropdownList.add(
        DropdownMenuEntry<String>(
          value: measuramentUnits[i],
          label: measuramentUnits[i],
        ),
      );
    }
    return dropdownList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: ModifyListProperty(
            propertyName: quantityProperty,
            widget: TextField(
              style: fieldStyle,
              maxLength: 6,
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],

              onChanged: (value) {
                int? quantityInt = int.tryParse(controller!.text);
                singleListManager.saveProperty(
                  id,
                  SingleListProperty.quantityValue,
                  quantityInt,
                  isPermanent: false,
                );
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        DropdownMenu<String>(
          width: 100,
          textStyle: (Theme.of(context).textTheme.bodyMedium)!.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),

          initialSelection: getInitialSelection(),
          dropdownMenuEntries: getDropdownEntries(),

          onSelected: (value) {
            singleListManager.saveProperty(
              id,
              SingleListProperty.quantityMeasurementUnit,
              value,
              isPermanent: false,
            );
          },
        ),
      ],
    );
  }

  String getInitialSelection() {
    if (singleListManager.getProperty(
          id,
          SingleListProperty.quantityMeasurementUnit,
        ) !=
        null) {
      return singleListManager.getProperty(
        id,
        SingleListProperty.quantityMeasurementUnit,
      );
    } else {
      return getDropdownEntries()
          .last
          .value; //careful with default selection, has to be compatible with default value when listitem is created
    }
  }
}
