import 'package:flutter/material.dart';
import 'package:foodplan/components/custom_search_bar.dart';
import 'package:foodplan/components/list_item.dart';

class SingleListPage extends StatefulWidget {
  const SingleListPage({super.key});

  @override
  State<SingleListPage> createState() => _SingleListPageState();
}

class _SingleListPageState extends State<SingleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.mode_edit_outlined, size: 28)],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actionsPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      body: BodyContent(),
    );
  }
}

class BodyContent extends StatelessWidget {
  const BodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        spacing: 20,
        children: [CustomSearchBar(), _NeededItems(), _AtHomeItems()],
      ),
    );
  }
}

class _NeededItems extends StatelessWidget {
  final List<ListItem> itemsList = [
    ListItem(),
    ListItem(),
    ListItem(),
    ListItem(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        spacing: 10,
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
          ...itemsList,
        ],
      ),
    );
  }
}

class _AtHomeItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
