import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:foodplan/models/enums/single_list_property.dart';

class QuantityProperty extends StatelessWidget {
  QuantityProperty({
    super.key,
    required this.quantityProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
  });

  final String quantityProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;

  final List<String> measuramentUnits = ["g", "hg", "kg", "mg", ""];

  List<DropdownMenuEntry> getDropdownEntries() {
    List<DropdownMenuEntry> dropdownList = [];
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
              style: (Theme.of(context).textTheme.titleSmall)!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
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
        DropdownMenu(
          width: 100,
          textStyle: (Theme.of(context).textTheme.bodyMedium)!.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          initialSelection:
              singleListManager.getProperty(
                id,
                SingleListProperty.quantityMeasurementUnit,
              ) ??
              getDropdownEntries().last,
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
}
