import 'package:flutter/material.dart';

import 'package:foodplan/components/single_properties/category_property.dart';
import 'package:foodplan/components/single_properties/date_property.dart';
import 'package:foodplan/components/single_properties/description_property.dart';
import 'package:foodplan/components/single_properties/price_property.dart';
import 'package:foodplan/components/single_properties/quantity_property.dart';
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

    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO: ONLY SAVE ON SAVE BUTTON
        CategoryProperty(
          categoryProperty: property1,
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
