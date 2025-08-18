import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodplan/components/editable_title.dart';
import 'package:foodplan/components/modify_list_property.dart';

import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/properties/single_list_property.dart';

import 'package:provider/provider.dart';

class ModifyListItemPage extends StatefulWidget {
  const ModifyListItemPage({super.key, required this.id});
  final String id;

  @override
  State<ModifyListItemPage> createState() => _ModifyListItemPageState();
}

class _ModifyListItemPageState extends State<ModifyListItemPage> {
  late TextEditingController controller;
  @override
  void initState() {
    final String title = context.read<SingleListManager>().getProperty(
      widget.id,
      SingleListProperty.title,
    );
    controller = TextEditingController(text: title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final singleListManager = context.read<SingleListManager>();
    final TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              singleListManager.removeItem(widget.id);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Eliminato")));
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amber,
          child: Column(
            spacing: 20,
            children: [
              Container(
                height: 300,
                padding: EdgeInsets.only(
                  right: 50,
                  left: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Center(child: Placeholder()),
              ),
              Container(
                height: 600,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: EditableTitle<SingleListManager>(
                              //TODO:save on title also
                              textEditingController: controller,
                              id: widget.id,
                              context: context,
                              isAutofocused: false,
                              textAlign: TextAlign.center,
                              maxLength: 20,
                              titleStyle: titleStyle,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Properties(id: widget.id),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          singleListManager.notifyChange();
                        },
                        child: Text("Salva"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO: ONLY SAVE ON SAVE BUTTON
        CategoryProperty(
          property1: property1,
          controller: controllerMap[property1],
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
          property4: property4,
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
        readOnly: true,
        onTap: () async {
          singleListManager.setDate(id, context, controller!);
        },
      ),
    );
  }
}

class DescriptionProperty extends StatelessWidget {
  const DescriptionProperty({
    super.key,
    required this.property4,
    required this.controller,
    required this.singleListManager,
    required this.id,
    required this.propertyMap,
  });

  final String property4;
  final TextEditingController? controller;
  final SingleListManager singleListManager;
  final String id;
  final Map<String, SingleListProperty> propertyMap;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: property4,
      widget: TextField(
        controller: controller,

        onSubmitted: (value) {
          singleListManager.saveProperty(id, propertyMap[property4]!, value);
        },
      ),
    );
  }
}

class CategoryProperty extends StatelessWidget {
  const CategoryProperty({
    super.key,
    required this.property1,
    required this.controller,
  });

  final String property1;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return ModifyListProperty(
      propertyName: property1,
      widget: TextField(
        controller: controller,

        onSubmitted: (value) {
          // saveManager.saveCategory(singleListManager, id, value);
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
            isNotified: false,
          );
        },
        onSubmitted: (value) {
          double? priceDouble = double.tryParse(value);
          singleListManager.saveProperty(
            id,
            propertyMap[priceProperty]!,
            priceDouble,
          );
        },
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
        ModifyListProperty(
          propertyName: quantityProperty,
          widget: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            onSubmitted: (value) {
              int? quantityInt = int.tryParse(value);
              singleListManager.saveProperty(
                id,
                propertyMap[quantityProperty]!,
                quantityInt,
              );
            },
          ),
        ),
        SizedBox(
          width: 80,
          child: DropdownMenu(dropdownMenuEntries: getDropdownEntries()),
        ),
      ],
    );
  }
}
