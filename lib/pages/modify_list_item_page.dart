import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodplan/components/editable_title.dart';
import 'package:foodplan/components/modify_list_property.dart';

import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/properties/single_list_property.dart';

import 'package:provider/provider.dart';

class ModifyListItemPage extends StatelessWidget {
  const ModifyListItemPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final listItemManager = context.read<SingleListManager>();
    final String title = listItemManager.getProperty(
      id,
      SingleListProperty.title,
    );
    final TextEditingController controller = TextEditingController(text: title);
    final TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              listItemManager.removeItem(id);
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
                              //TODO:savemanager on title also
                              textEditingController: controller,
                              id: id,
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
                        child: Properties(id: id),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
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

class Properties extends StatelessWidget {
  const Properties({super.key, required this.id});
  final String id;
  final String property1 = "Categoria";
  final String property2 = "Prezzo";
  final String property3 = "Quantita'";
  final String property4 = "Descrizione";
  final String property5 = "Scadenza";

  @override
  Widget build(BuildContext context) {
    final SingleListManager singleListManager = context.read();
    final String? category = singleListManager.getProperty(
      id,
      SingleListProperty.category,
    );
    final double? price = singleListManager.getProperty(
      id,
      SingleListProperty.price,
    );
    final int? quantity = singleListManager.getProperty(
      id,
      SingleListProperty.quantityValue,
    );
    final String? subtitle = singleListManager.getProperty(
      id,
      SingleListProperty.subtitle,
    );
    final DateTime? expireDate = singleListManager.getProperty(
      id,
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
        text: valueBeforeMap[property1].toString(),
      ),
      property2: TextEditingController(
        text: valueBeforeMap[property2].toString(),
      ),
      property3: TextEditingController(
        text: valueBeforeMap[property3].toString(),
      ),
      property4: TextEditingController(
        text: valueBeforeMap[property4].toString(),
      ),
      property5: TextEditingController(
        text: valueBeforeMap[property5].toString() == "null"
            ? ""
            : '${valueBeforeMap[property5].day}/${valueBeforeMap[property5].month}/${valueBeforeMap[property5].year}',
      ),
    };

    void undoChanges(
      TextEditingController textEditingController,
      dynamic valueBefore,
    ) {
      //TODO: choose when to undo changes and when not
      FocusScope.of(context).unfocus();

      textEditingController.text = valueBefore.toString();
    }

    return Column(
      children: [
        //TODO: ONLY SAVE ON SAVE BUTTON
        ModifyListProperty(
          propertyName: property1,
          widget: TextField(
            controller: controllerMap[property1],

            onSubmitted: (value) {
              // saveManager.saveCategory(singleListManager, id, value);
            },
          ),
        ),
        ModifyListProperty(
          propertyName: property2,

          widget: TextField(
            controller: controllerMap[property2],
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],

            onSubmitted: (value) {
              singleListManager.savePrice(id, value);
            },
          ),
        ),
        ModifyListProperty(
          propertyName: property3,
          widget: TextField(
            controller: controllerMap[property3],

            onSubmitted: (value) {
              singleListManager.saveQuantity(id, value);
            },
          ),
        ),

        ModifyListProperty(
          propertyName: property5,
          widget: TextField(
            controller: controllerMap[property5],
            readOnly: true,
            onTap: () async {
              singleListManager.saveDate(
                id,
                context,
                controllerMap[property5]!,
              );
            },
          ),
        ),
        ModifyListProperty(
          propertyName: property4,
          widget: TextField(
            controller: controllerMap[property4],

            onSubmitted: (value) {
              singleListManager.saveSubtitle(id, value);
            },
          ),
        ),
      ],
    );
  }
}
