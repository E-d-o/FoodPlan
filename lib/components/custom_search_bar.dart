import 'package:flutter/material.dart';
import 'package:foodplan/managers/single_list_manager.dart';

import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, this.isAutoFocused = false});
  final bool isAutoFocused;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _searchFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SingleListManager singleListManager = context.read<SingleListManager>();
    return SearchBar(
      autoFocus: widget.isAutoFocused,
      focusNode: _searchFocusNode,
      controller: _textEditingController,

      leading: IconButton(
        onPressed: () {
          singleListManager.changeAddingState();
        },
        icon: singleListManager.isAdding
            ? Icon(Icons.arrow_back)
            : Icon(Icons.search),
      ),
      trailing: <Widget>[
        IconButton(
          onPressed: () {
            singleListManager.changeAddingState();
          },
          icon: Icon(Icons.add_circle_outline),
        ),
      ],
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 2)),
      hintText: "Aggiungi elemento",
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.0),
        ),
      ),
      side: WidgetStateProperty.all(
        BorderSide(color: Colors.black, width: 2.0),
      ),
      hintStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.labelMedium,
      ),

      onTap: () {
        if (!singleListManager.isAdding) {
          singleListManager.changeAddingState();
        }
      },
      onChanged: (value) {
        singleListManager.filterSuggestions(value);
        singleListManager.editingTextSuggestion(value);
      },

      onTapOutside: (event) {
        _searchFocusNode.unfocus();
      },
    );
  }
}
