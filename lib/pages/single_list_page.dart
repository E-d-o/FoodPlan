import 'package:flutter/material.dart';
import 'package:foodplan/components/at_home_items.dart';
import 'package:foodplan/components/needed_items.dart';
import 'package:foodplan/components/custom_search_bar.dart';
import 'package:foodplan/components/single_list_bottom_sheet.dart';
import 'package:foodplan/models/main_list_manager.dart';
import 'package:foodplan/models/single_list_manager.dart';
import 'package:foodplan/pages/add_page.dart';
import 'package:provider/provider.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              MainListManager mainListManager = context.read<MainListManager>();
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: mainListManager,
                    builder: (context, child) => SingleListBottomSheet(),
                  );
                },
              );
            },
            icon: Icon(Icons.mode_edit_outlined, size: 28),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
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
    SingleListManager singleListManager = context.watch<SingleListManager>();

    if (singleListManager.isAdding) {
      return AddPage();
    } else {
      return SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          spacing: 20,
          children: [CustomSearchBar(), NeededItems(), AtHomeItems()],
        ),
      );
    }
  }
}
