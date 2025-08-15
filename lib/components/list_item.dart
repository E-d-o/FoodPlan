import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    final singleListManager = context.read<SingleListManager>();
    return Dismissible(
      key: Key(id),
      background: Container(color: Colors.redAccent),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        singleListManager.removeItem(id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Rimosso elemento :D")));
      },
      child: Material(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(3.0),

        child: InkResponse(
          splashColor: Theme.of(context).splashColor,

          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(3.0),
          containedInkWell: true,
          onTap: () {
            //TODO: add logic ontap listitem
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
    final title = singleListManager.getTitle(id);
    final subtitle = singleListManager.getSubtitle(id);

    return Expanded(
      flex: 4,
      child: Container(
        height: double.infinity,
        color: Colors.amber,
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
                Text(title, style: null),
                HidableSubtitle(subtitle: subtitle),
              ],
            ),
            Container(
              height: 30,
              width: 30,
              color: Colors.green,
              child: Text("My image"),
            ),
          ],
        ),
      ),
    );
  }
}

class HidableSubtitle extends StatelessWidget {
  const HidableSubtitle({super.key, required this.subtitle});

  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    if (subtitle == null) {
      isVisible = false;
      return Visibility(
        visible: isVisible,
        child: Text("dovrebbe essere invisibile", style: null),
      );
    } else {
      return Visibility(
        visible: isVisible,
        child: Text(subtitle!, style: null),
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
    final double? price = singleListManager.getPrice(id);
    final String? priceMeasurementUnit = singleListManager
        .getPriceMeasurementUnit(id);
    final int? quantity = singleListManager.getQuantity(id);
    final String? measurementUnit = singleListManager.getMeasurementUnit(id);
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
            quantityPart(quantity, measurementUnit, context),
            pricePart(price, priceMeasurementUnit, context),
          ],
        ),
      ),
    );
  }

  Visibility pricePart(
    double? price,
    String? priceMeasurementUnit,
    BuildContext context,
  ) {
    if (price == null) {
      return Visibility(
        visible: false,
        child: Text("this price should not be visible"),
      );
    } else {
      if (price.floor() - price == 0) {
        //if is int
        return Visibility(
          visible: true,
          child: Text(
            price.toInt().toString() +
                priceMeasurementUnit!, //cant get here with no quantity so measurment unit is not null here
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      }
      return Visibility(
        visible: true,
        child: Text(
          price.toString() + priceMeasurementUnit!,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
  }

  Visibility quantityPart(
    int? quantity,
    String? measurementUnit,
    BuildContext context,
  ) {
    if (quantity == null) {
      return Visibility(
        visible: false,
        child: Text("this price should not be visible"),
      );
    } else {
      return Visibility(
        visible: true,
        child: Text(
          quantity.toString() +
              measurementUnit!, //cant get here with no quantity so measurment unit is not null here
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
  }
}
