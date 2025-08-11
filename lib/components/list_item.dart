import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(3.0),

      child: InkResponse(
        splashColor: Theme.of(context).splashColor,

        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(3.0),
        containedInkWell: true,
        onTap: () {
          print("Tapped listItem");
        },
        child: mainStructure(context),
      ),
    );
  }

  Container mainStructure(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 12),
      child: Row(spacing: 8, children: [LeftItemPart(), RightItemPart()]),
    );
  }
}

class LeftItemPart extends StatefulWidget {
  const LeftItemPart({super.key});

  @override
  State<LeftItemPart> createState() => _LeftItemPartState();
}

class _LeftItemPartState extends State<LeftItemPart> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
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
              value: checkValue,
              onChanged: (value) {
                setState(() {
                  checkValue = value!;
                });
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("data", style: Theme.of(context).textTheme.displaySmall),
                Text("Subtitle", style: Theme.of(context).textTheme.bodySmall),
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
