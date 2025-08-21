import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:foodplan/models/enums/single_list_property.dart';

class PriceProperty extends StatelessWidget {
  const PriceProperty({
    super.key,
    required this.priceProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
  });

  final String priceProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: priceProperty,

      widget: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(),
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            int periodNumber = '.'.allMatches(newValue.text).length;
            int commaNumber = ','.allMatches(newValue.text).length;
            int decimalSeparatorCount = periodNumber + commaNumber;
            if (decimalSeparatorCount > 1) {
              return oldValue;
            }
            return newValue;
          }),
        ],

        onChanged: (value) {
          double? priceDouble = double.tryParse(controller!.text);
          singleListManager.saveProperty(
            id,
            SingleListProperty.price,
            priceDouble,
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
