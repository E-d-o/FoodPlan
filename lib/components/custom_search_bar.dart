import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      focusNode: _searchFocusNode,
      leading: Icon(Icons.search),
      trailing: <Widget>[Icon(Icons.add_circle_outline)],
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
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

      onTapOutside: (event) {
        _searchFocusNode.unfocus();
      },
    );
  }
}
