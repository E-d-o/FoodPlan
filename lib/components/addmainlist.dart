import 'package:flutter/material.dart';

class AddMainList extends StatefulWidget {
  const AddMainList({super.key});

  @override
  State<AddMainList> createState() => _AddMainListState();
}

class _AddMainListState extends State<AddMainList> {
  List containerColors = [Colors.greenAccent, Colors.deepPurpleAccent];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: containerColors[0],
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: InkResponse(
        splashColor: Colors.teal,
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        containedInkWell: true,
        onTap: () {
          setState(() {
            Color change = containerColors[0];
            containerColors[0] = containerColors[1];
            containerColors[1] = change;
          });
        },
        child: Container(
          height: 100,
          width: double.infinity,
          padding: EdgeInsets.all(18),

          child: Center(
            child: Text(
              "Aggiungi Lista",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
