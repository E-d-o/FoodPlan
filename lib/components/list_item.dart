import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.id, required this.isAtHome});
  final bool isAtHome;
  final String id;
  @override
  Widget build(BuildContext context) {
    final singleListManager = context.read<SingleListManager>();
    return Dismissible(
      key: Key(id),
      background: Container(color: Colors.redAccent),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          singleListManager.removeItem(id, isAtHome);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Rimosso elemento :D")));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("NON PUOI :D")));
        }
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
            //TODO:Logic of ListItem onTap
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
          RightItemPart(),
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
                Text("data", style: null),
                Text("Subtitle", style: null),
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

class RightItemPart extends StatelessWidget {
  const RightItemPart({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text("x1", style: Theme.of(context).textTheme.bodySmall),
            Text("2\$", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
