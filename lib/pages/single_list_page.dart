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
  final SingleListManager singleListManager = SingleListManager();
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

class _AtHomeItems extends StatelessWidget {
  static const double topRadiusTextRegion = 10.0;
  @override
  Widget build(BuildContext context) {
    final singleListManager = context.watch<SingleListManager>();
    final atHomeItems = singleListManager.homeItemsList;

    return Selector<SingleListManager, bool>(
      //handles the rebuilding of _AtHomeItems based on the changing of only the value of isHomeItemsVisible
      selector: (context, provider) => provider.isHomeItemsVisible,
      builder: (context, isVisible, child) {
        return Column(
          spacing: 0,
          children: [
            TextRegion(topRadiusTextRegion: topRadiusTextRegion),
            HidableList(
              atHomeItems: atHomeItems,
              isVisible: isVisible,
              manager: singleListManager,
            ),
          ],
        );
      },
    );
  }
}

class HidableList extends StatelessWidget {
  const HidableList({
    super.key,
    required this.atHomeItems,
    required this.isVisible,
    required this.manager,
  });
  final bool isVisible;
  final List<ListItem> atHomeItems;
  final SingleListManager manager;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: EdgeInsets.all(manager.paddingHomeItems),
        child: Column(spacing: 10, children: [...atHomeItems]),
      ),
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
    final Color backgroundColor = Theme.of(
      context,
    ).colorScheme.secondaryContainer;
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer);
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
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Gia' acquistati", style: textStyle),
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
