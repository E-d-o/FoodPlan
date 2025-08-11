import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

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

  SizedBox mainStructure(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Row(spacing: 10, children: [LeftItemPart(), RightItemPart()]),
    );
  }
}

class LeftItemPart extends StatelessWidget {
  const LeftItemPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.lightGreenAccent,
                child: Text("data", textAlign: TextAlign.center),
              ),
            ),
            Container(height: 18, width: 18, color: Colors.green),
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
        decoration: BoxDecoration(
          border: BoxBorder.fromLTRB(
            left: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
      ),
    );
  }
}
