import 'package:flutter/material.dart';
import 'package:foodplan/components/single_properties/category_property.dart';
import 'package:foodplan/components/single_properties/date_property.dart';
import 'package:foodplan/components/single_properties/description_property.dart';
import 'package:foodplan/components/single_properties/price_property.dart';
import 'package:foodplan/components/single_properties/quantity_property.dart';
import 'package:foodplan/models/single_list_manager.dart';
import 'package:foodplan/properties/enums/single_list_property.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SingleListManager singleListManager = context.read();
    TextStyle fieldStyle = (Theme.of(context).textTheme.titleSmall)!.copyWith(
      color: Theme.of(context).colorScheme.onSecondaryContainer,
    );
    final String? category = singleListManager.getProperty(
      widget.id,
      SingleListProperty.category,
      isPermanent: false,
    );
    final double? price = singleListManager.getProperty(
      widget.id,
      SingleListProperty.price,
      isPermanent: false,
    );
    final int? quantity = singleListManager.getProperty(
      widget.id,
      SingleListProperty.quantityValue,
      isPermanent: false,
    );
    final String? subtitle = singleListManager.getProperty(
      widget.id,
      SingleListProperty.subtitle,
      isPermanent: false,
    );
    final DateTime? expireDate = singleListManager.getProperty(
      widget.id,
      SingleListProperty.expireDate,
      isPermanent: false,
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
        CategoryProperty(
          categoryProperty: property1,
          controller: controllerMap[property1],
          singleListManager: singleListManager,
          id: widget.id,
          fieldStyle: fieldStyle,
        ),
        PriceProperty(
          priceProperty: property2,
          controller: controllerMap[property2],
          singleListManager: singleListManager,
          id: widget.id,
          fieldStyle: fieldStyle,
        ),
        QuantityProperty(
          quantityProperty: property3,
          controller: controllerMap[property3],
          singleListManager: singleListManager,
          id: widget.id,
          fieldStyle: fieldStyle,
        ),

        DateProperty(
          property5: property5,
          controller: controllerMap[property5],
          singleListManager: singleListManager,
          id: widget.id,
          fieldStyle: fieldStyle,
        ),
        DescriptionProperty(
          descriptionProperty: property4,
          controller: controllerMap[property4],
          singleListManager: singleListManager,
          id: widget.id,
          fieldStyle: fieldStyle,
        ),
      ],
    );
  }
}
