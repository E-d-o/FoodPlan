import 'package:flutter/material.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:foodplan/pages/modify_list_item_page.dart';
import 'package:foodplan/models/enums/single_list_property.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  //TODO:implement multiple selectable items
  const ListItem({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    final singleListManager = context.read<SingleListManager>();
    final Color backgroundColor = Theme.of(context).colorScheme.secondary;
    final Color dismissBackground = Theme.of(context).colorScheme.error;

    return Dismissible(
      key: Key(id),
      background: Container(color: dismissBackground),
      direction: DismissDirection.endToStart,

      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Conferma eliminazione?"),
              content: Text("Vuoi davvero eliminare questo elemento?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Annulla"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Elimina"),
                ),
              ],
            );
          },
        );
      },

      onDismissed: (direction) {
        singleListManager.removeItem(id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Rimosso elemento :D")));
      },
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(3.0),

        child: InkResponse(
          splashColor: Colors.blueAccent,

          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(3.0),
          containedInkWell: true,
          onLongPress: () {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
              barrierColor: Colors.transparent,
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            singleListManager.renameItem(
                              id,
                              "sdfkj",
                            ); //TODO:editable title in listitem
                          },
                          child: Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Rinomina"),
                              Icon(Icons.edit_square),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            singleListManager.removeItem(id);
                          },
                          child: Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Elimina"), Icon(Icons.delete)],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            singleListManager.copyItem(id);
                          },
                          child: Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Copia"),
                              Icon(Icons.copy_all_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: singleListManager,
                    child: ModifyListItemPage(
                      id: id,
                    ), //change with modify item page
                  );
                },
              ),
            );
          },
          child: mainStructure(context),
        ),
      ),
    );
  }

  Container mainStructure(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 12),
      child: Row(
        spacing: 8,
        children: [
          LeftItemPart(id: id),
          RightItemPart(id: id),
        ],
      ),
    );
  }
}

class LeftItemPart extends StatelessWidget {
  const LeftItemPart({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final singleListManager = context.watch<SingleListManager>();
    final title = singleListManager.getProperty(id, SingleListProperty.title);
    final subtitle = singleListManager.getProperty(
      id,
      SingleListProperty.subtitle,
    );
    final TextStyle? titleStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onSecondary);
    final TextStyle? subtitleStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSecondary);

    return Expanded(
      flex: 4,
      child: Container(
        height: double.infinity,
        color: Colors.transparent, //can change for testing
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: singleListManager.getCheckedValue(id),
              onChanged: (value) {
                singleListManager.changeCheckedValue(id);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: titleStyle),
                HidableSubtitle(
                  subtitle: subtitle,
                  subtitleStyle: subtitleStyle,
                ),
              ],
            ),
            HidableImage(),
          ],
        ),
      ),
    );
  }
}

class HidableImage extends StatelessWidget {
  const HidableImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(
        //TODO: IMPLEMENT HidableImage
        height: 30,
        width: 30,
        color: Colors.green,
        child: Text("My image"),
      ),
    );
  }
}

class HidableSubtitle extends StatelessWidget {
  const HidableSubtitle({
    super.key,
    required this.subtitle,
    required this.subtitleStyle,
  });

  final String? subtitle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    if (subtitle == null) {
      isVisible = false;
      return SizedBox.shrink();
    } else {
      return Visibility(
        visible: isVisible,
        child: Text(subtitle!, style: subtitleStyle),
      );
    }
  }
}

class RightItemPart extends StatelessWidget {
  const RightItemPart({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    final singleListManager = context.watch<SingleListManager>();
    final double? price = singleListManager.getProperty(
      id,
      SingleListProperty.price,
    );
    final String? priceMeasurementUnit = singleListManager.getProperty(
      id,
      SingleListProperty.priceMeasurementUnit,
    );
    final int? quantity = singleListManager.getProperty(
      id,
      SingleListProperty.quantityValue,
    );
    final String? quantityMeasurementUnit = singleListManager.getProperty(
      id,
      SingleListProperty.quantityMeasurementUnit,
    );
    final TextStyle? textStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSecondary);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: BoxBorder.fromLTRB(
            left: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            quantityPart(quantity, quantityMeasurementUnit, textStyle, context),
            pricePart(price, priceMeasurementUnit, textStyle, context),
          ],
        ),
      ),
    );
  }

  Widget pricePart(
    double? price,
    String? priceMeasurementUnit,
    TextStyle? textStyle,
    BuildContext context,
  ) {
    if (price == null) {
      return SizedBox.shrink();
    } else {
      if (price.floor() - price == 0) {
        //if is int
        return Text(
          price.toInt().toString() +
              priceMeasurementUnit!, //cant get here with no quantity so measurment unit is not null here
          style: textStyle,
        );
      }
      return Text(price.toString() + priceMeasurementUnit!, style: textStyle);
    }
  }

  Widget quantityPart(
    int? quantity,
    String? measurementUnit,
    TextStyle? textStyle,
    BuildContext context,
  ) {
    if (quantity == null) {
      return SizedBox.shrink();
    } else {
      return Text(
        quantity.toString() +
            measurementUnit!, //cant get here with no quantity so measurment unit is not null here
        style: textStyle,
      );
    }
  }
}
