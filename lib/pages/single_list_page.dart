import 'package:flutter/material.dart';
import 'package:foodplan/components/custom_search_bar.dart';
import 'package:foodplan/components/list_item.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
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
      padding: EdgeInsets.all(12),
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

class _AtHomeItems extends StatelessWidget {
  final List<ListItem> atHomeItems = [ListItem(), ListItem(), ListItem()];
  static const double topRadiusTextRegion = 10.0;
  @override
  Widget build(BuildContext context) {
    return Selector<SingleListManager, bool>(
      //handles the rebuilding of _AtHomeItems based on the changing of only the value of isHomeItemsVisible
      selector: (context, provider) => provider.isHomeItemsVisible,
      builder: (context, isVisible, child) {
        return Column(
          spacing: 0,
          children: [
            TextRegion(topRadiusTextRegion: topRadiusTextRegion),
            Visibility(
              visible: isVisible,
              child: Container(
                color: Colors.grey,
                padding: EdgeInsets.all(12.0),
                child: Column(spacing: 10, children: [...atHomeItems]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TextRegion extends StatelessWidget {
  const TextRegion({super.key, required this.topRadiusTextRegion});

  final double topRadiusTextRegion;

  @override
  Widget build(BuildContext context) {
    final singleListManager = Provider.of<SingleListManager>(
      context,
      listen: false,
    );
    return GestureDetector(
      onTap: () {
        singleListManager.changeHomeItemsVisibility();
      },
      child: Container(
        height: 70,
        width: double.infinity,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadiusTextRegion),
            topRight: Radius.circular(topRadiusTextRegion),
          ),
          color: Colors.blueAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              "Gia' acquistati",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            _ChangingIcon(),
          ],
        ),
      ),
    );
  }
}

class _ChangingIcon extends StatelessWidget {
  // ignore: unused_element_parameter
  const _ChangingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final singleListManager = Provider.of<SingleListManager>(
      context,
      listen: false,
    );
    if (singleListManager.isHomeItemsVisible) {
      return Icon(Icons.arrow_drop_down);
    } else {
      return Icon(Icons.arrow_drop_up);
    }
  }
}
