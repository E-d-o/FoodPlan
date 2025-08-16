import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:provider/provider.dart';

class AddMainList extends StatelessWidget {
  const AddMainList({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backGroundColor = Theme.of(context).colorScheme.secondary;
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onSecondary);

    return Material(
      color: backGroundColor,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: InkResponse(
        splashColor: Theme.of(context).splashColor,
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        containedInkWell: true,
        onTap: () {
          //notifies body in order to add a new list
          final managerLists = Provider.of<MainListManager>(
            context,
            listen: false,
          );
          managerLists.addMainList();
        },
        child: Container(
          height: 100,
          width: double.infinity,
          padding: EdgeInsets.all(18),

          child: Center(child: Text("Aggiungi Lista", style: textStyle)),
        ),
      ),
    );
  }
}
