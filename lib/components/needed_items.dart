import 'package:flutter/material.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:foodplan/models/single_list_manager.dart';
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
          ItemsList(itemsList: itemsList),
        ],
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.itemsList});

  final List<ListItem> itemsList;

  @override
  Widget build(BuildContext context) {
    final singleListManager = context.read<SingleListManager>();
    if (singleListManager.isBoxFirstEmpty) {
      return Row(
        children: [
          Flexible(
            child: Wrap(
              children: [
                Text(
                  "Aggiungi un elemento cliccando sulla barra di ricerca!",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(spacing: 10, children: [...itemsList]);
    }
  }
}
