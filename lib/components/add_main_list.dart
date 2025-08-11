import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/add_main_list_notifier.dart';

class AddMainList extends StatefulWidget {
  const AddMainList({super.key, required this.listNotifier});
  final AddMainListNotifier listNotifier;

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
          //cosmetics
          setState(() {
            Color change = containerColors[0];
            containerColors[0] = containerColors[1];
            containerColors[1] = change;
          });
          //notifies body in order to add a new list
          widget.listNotifier.addMainList();
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
