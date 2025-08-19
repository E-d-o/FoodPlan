import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodplan/components/modify_list_property.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/properties/single_list_property.dart';
import 'package:provider/provider.dart';

class Properties extends StatefulWidget {
  const Properties({super.key, required this.id});
  final String id;

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  final String property1 = "Categoria";

  final String property2 = "Prezzo";

  final String property3 = "Quantita'";

  final String property4 = "Descrizione";

  final String property5 = "Scadenza";
  late final Map<String, SingleListProperty> propertyMap;

  @override
  void initState() {
    propertyMap = {
      property1: SingleListProperty.category,
      property2: SingleListProperty.price,
      property3: SingleListProperty.quantityValue,
      property4: SingleListProperty.subtitle,
      property5: SingleListProperty.expireDate,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SingleListManager singleListManager = context.read();
    final String? category = singleListManager.getProperty(
      widget.id,
      SingleListProperty.category,
    );
    final double? price = singleListManager.getProperty(
      widget.id,
      SingleListProperty.price,
    );
    final int? quantity = singleListManager.getProperty(
      widget.id,
      SingleListProperty.quantityValue,
    );
    final String? subtitle = singleListManager.getProperty(
      widget.id,
      SingleListProperty.subtitle,
    );
    final DateTime? expireDate = singleListManager.getProperty(
      widget.id,
      SingleListProperty.expireDate,
    );

    final Map<String, dynamic> valueBeforeMap = {
      property1: category,
      property2: price,
      property3: quantity,

      property4: subtitle,
      property5: expireDate,
    };
    final Map<String, TextEditingController> controllerMap = {
      property1: TextEditingController(
        text: valueBeforeMap[property1].toString() == "null"
            ? ""
            : valueBeforeMap[property1].toString(),
      ),
      property2: TextEditingController(
        text: valueBeforeMap[property2].toString() == "null"
            ? ""
            : valueBeforeMap[property2].toString(),
      ),
      property3: TextEditingController(
        text: valueBeforeMap[property3].toString() == "null"
            ? ""
            : valueBeforeMap[property3].toString(),
      ),
      property4: TextEditingController(
        text: valueBeforeMap[property4].toString() == "null"
            ? ""
            : valueBeforeMap[property4].toString(),
      ),
      property5: TextEditingController(
        text: valueBeforeMap[property5].toString() == "null"
            ? ""
            : '${valueBeforeMap[property5].day}/${valueBeforeMap[property5].month}/${valueBeforeMap[property5].year}',
      ),
    };
    /*
    void undoChanges(
      TextEditingController textEditingController,
      dynamic valueBefore,
    ) {
      //TODO: choose when to undo changes and when not
      FocusScope.of(context).unfocus();

      textEditingController.text = valueBefore.toString();
    }
    */
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO: ONLY SAVE ON SAVE BUTTON
        CategoryProperty(
          property1: property1,
          controller: controllerMap[property1],
          singleListManager: singleListManager,
          id: widget.id,
        ),
        PriceProperty(
          priceProperty: property2,
          controller: controllerMap[property2],
          singleListManager: singleListManager,
          id: widget.id,
          propertyMap: propertyMap,
        ),
        QuantityProperty(
          quantityProperty: property3,
          controller: controllerMap[property3],
          singleListManager: singleListManager,
          id: widget.id,
          propertyMap: propertyMap,
        ),

        DateProperty(
          property5: property5,
          controller: controllerMap[property5],
          singleListManager: singleListManager,
          id: widget.id,
        ),
        DescriptionProperty(
          descriptionProperty: property4,
          controller: controllerMap[property4],
          singleListManager: singleListManager,
          id: widget.id,
          propertyMap: propertyMap,
        ),
      ],
    );
  }
}

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

class DescriptionProperty extends StatelessWidget {
  const DescriptionProperty({
    super.key,
    required this.descriptionProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.propertyMap,
  });

  final String descriptionProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final Map<String, SingleListProperty> propertyMap;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: descriptionProperty,
      fieldHeight: 200,

      widget: TextField(
        controller: controller,
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        onTapOutside: (event) {
          String? descriptionText = controller!.text;
          singleListManager.saveProperty(
            id,
            propertyMap[descriptionProperty]!, //TODO: refactor without property map, i already know that im in quantity
            descriptionText,
            isPermanent: false,
          );
        },
        onSubmitted: (value) {},
      ),
    );
  }
}

class CategoryProperty extends StatelessWidget {
  const CategoryProperty({
    super.key,
    required this.property1,
    required this.controller,
    required this.singleListManager,
    required this.id,
  });

  final String property1;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: property1,

      widget: TextField(
        controller: controller,
        textAlign: TextAlign.center,

        onSubmitted: (value) {
          // singleListManager.saveProperty(id, SignleListP, property)
        },
      ),
    );
  }
}

class PriceProperty extends StatelessWidget {
  const PriceProperty({
    super.key,
    required this.priceProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.propertyMap,
  });

  final String priceProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final Map<String, SingleListProperty> propertyMap;

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

        onTapOutside: (event) {
          //TODO: fix when save it should undo changes when i pop out of page
          double? priceDouble = double.tryParse(controller!.text);
          singleListManager.saveProperty(
            id,
            propertyMap[priceProperty]!,
            priceDouble,
            isPermanent: false,
          );
        },
        onSubmitted: (value) {},
      ),
    );
  }
}

/*

 SizedBox(
          width: 100,
          child: DropdownMenu(
            dropdownMenuEntries: [
              DropdownMenuEntry<String>(value: "g", label: "g"),
            ],
          ),
        ),

*/

class QuantityProperty extends StatelessWidget {
  QuantityProperty({
    super.key,
    required this.quantityProperty,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.propertyMap,
  });

  final String quantityProperty;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final Map<String, SingleListProperty> propertyMap;
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
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],

              onTapOutside: (event) {
                int? quantityInt = int.tryParse(controller!.text);
                singleListManager.saveProperty(
                  id,
                  propertyMap[quantityProperty]!, //TODO: refactor without property map, i already know that im in quantity
                  quantityInt,
                  isPermanent: false,
                );
              },
              onSubmitted: (value) {},
            ),
          ),
        ),
        DropdownMenu(
          width: 100,

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
            );
          },
        ),
      ],
    );
  }
}
