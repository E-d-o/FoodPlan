import 'package:flutter/material.dart';
import 'package:foodplan/components/custom_progress_indicator.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/pages/main_list_bottom_sheet.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';

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
  TextEditingController textEditingController = TextEditingController();
  final double borderRadius = 10.0;
  final singleListManager =
      SingleListManager(); //ogni mainlist ha il suo manager per la singlepagelist, cosi' da mantere lo stato di ogni mainlist
  @override
  void initState() {
    title = widget.givenTitle;
    textEditingController.text = title;

    super.initState();
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
    return SizedBox(
      height: boxHeight,
      width: double.infinity,
      child: Stack(
        children: [
          CustomProgressIndicator(
            borderRadius: borderRadius,
            height: boxHeight,
            manager: singleListManager,
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
                    EditableTitle(
                      textEditingController: textEditingController,
                      widget: widget,
                      context: context,
                    ),
                    Text("0/0"),
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
        splashColor: Colors.redAccent,
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
        child: Icon(Icons.more_vert, size: 28),
      ),
    );
  }
}

class EditableTitle extends StatelessWidget {
  //TODO: FIx bug that on rename every TItle is Editable at the same time, i want only the selected element to be editable
  const EditableTitle({
    super.key,
    required this.textEditingController,
    required this.widget,
    required this.context,
  });

  final TextEditingController textEditingController;
  final MainList widget;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Selector<MainListManager, bool>(
      selector: (context, provider) => provider.getEditStatus(widget.id),
      builder: (context, isEditing, child) {
        final listManager = Provider.of<MainListManager>(
          context,
          listen: false,
        );
        String changedTitle = listManager.getListTitle(widget.id);
        if (listManager.getEditStatus(widget.id)) {
          //introduce editstatus in manager and get it here, editstatus returns the isEditing for the specified id
          return SizedBox(
            width: 280,
            height: 24,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
              controller: textEditingController,
              autofocus: true,
              style: Theme.of(context).textTheme.bodyMedium,
              onSubmitted: (newTitle) {
                listManager.renameList(widget.id, newTitle);
              },
            ),
          );
        } else {
          return SizedBox(
            height: 24,
            child: Text(
              changedTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
      },
    );
  }
}
