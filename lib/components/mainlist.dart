import 'package:flutter/material.dart';
import 'package:foodplan/components/custom_progress_indicator.dart';
import 'package:foodplan/components/editable_title.dart';

import 'package:foodplan/pages/main_list_bottom_sheet.dart';
import 'package:foodplan/managers/main_list_manager.dart';

import 'package:provider/provider.dart';

class MainList extends StatefulWidget {
  const MainList({
    super.key,
    required this.id,
    this.givenTitle = "Nuova lista",
  });
  final String givenTitle;
  final String id;

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  late String title;
  late TextEditingController textEditingController;
  final double borderRadius = 10.0;

  @override
  void initState() {
    title = widget.givenTitle;
    textEditingController = TextEditingController(text: title);

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),

      child: mainStructure(context),
    );
  }

  SizedBox mainStructure(BuildContext context) {
    double boxHeight = 100;
    final MainListManager listManager = context.read<MainListManager>();
    textEditingController.text = listManager.getTitle(widget.id);
    final TextStyle? titleStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onPrimary);

    return SizedBox(
      height: boxHeight,
      width: double.infinity,
      child: Stack(
        children: [
          CustomProgressIndicator(
            borderRadius: borderRadius,
            height: boxHeight,

            id: widget.id,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 0,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [listSetting(context)],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EditableTitle<MainListManager>(
                      textEditingController: textEditingController,
                      id: widget.id,
                      context: context,
                      isAutofocused: true,
                      textAlign: TextAlign.start,
                      maxLength: 26,
                      titleStyle: titleStyle,
                    ),
                    //TODO:show save button to save EditableTitle changes
                    Text(
                      //TODO: use mainlistProperty to show proper value
                      "0/0",
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Material listSetting(BuildContext context) {
    double inkBorderRadius = 5;
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        splashColor: Theme.of(context).splashColor,
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(inkBorderRadius),
        containedInkWell: true,
        onTap: () {
          final listManager = Provider.of<MainListManager>(
            context,
            listen: false,
          );
          listManager.selectedId = widget.id;

          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            barrierColor: Colors.transparent,
            builder: (context) {
              return ChangeNotifierProvider.value(
                value: listManager,
                child: MainListBottomSheet(),
              );
            },
          );
        },
        child: Icon(
          Icons.more_vert,
          size: 28,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
