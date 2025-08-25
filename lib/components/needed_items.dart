import 'package:flutter/material.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:provider/provider.dart';

class NeededItems extends StatelessWidget {
  const NeededItems({super.key});

  @override
  Widget build(BuildContext context) {
    final singleListManager = context.watch<SingleListManager>();
    final itemsList = singleListManager.requiredItemsList;
    return Container(
      padding: EdgeInsets.all(18),
      width: double.infinity,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        spacing: 18,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Da prendere:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Column(spacing: 10, children: [...itemsList]),
        ],
      ),
    );
  }
}
