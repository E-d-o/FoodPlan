import 'package:flutter/material.dart';
import 'package:foodplan/components/custom_search_bar.dart';
import 'package:foodplan/components/suggestion_item.dart';
import 'package:foodplan/managers/single_list_manager.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    SingleListManager singleListManager = context.watch<SingleListManager>();
    List<String> filteredSuggestions = singleListManager.filteredSuggestions;
    List<SuggestionItem> suggestionItems = singleListManager
        .convertToSuggestionList(filteredSuggestions);
    singleListManager.resetSuggestions();

    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 20,
        children: [
          CustomSearchBar(isAutoFocused: true),
          ...suggestionItems,
          SizedBox(height: 200),
        ],
      ),
    );
  }
}
