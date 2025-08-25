import 'package:flutter/material.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:provider/provider.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    SingleListManager singleListManager = context.read<SingleListManager>();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListTile(
        title: Text(title),

        onTap: () {
          singleListManager.addNewItem(title);
          singleListManager.changeAddingState();
        },
      ),
    );
  }
}
