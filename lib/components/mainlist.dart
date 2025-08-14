import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:foodplan/pages/main_list_bottom_sheet.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:foodplan/pages/single_list_page.dart';
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
  @override
  void initState() {
    title = widget.givenTitle;
    textEditingController.text = title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final singleListManager =
        SingleListManager(); //ogni mainlist ha il suo manager per la singlepagelist, cosi' da mantere lo stato di ogni mainlist
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),

      child: InkResponse(
        //makes the ink splash bound to the cointainer which is a rectangle with circular radius 10.0
        splashColor: Theme.of(context).splashColor,

        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(borderRadius),
        containedInkWell: true,
        //end of ink splash section
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider.value(
                  value: singleListManager,
                  child: SingleListPage(),
                );
              },
            ),
          );
        },

        child: mainStructure(context),
      ),
    );
  }

  SizedBox mainStructure(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,

      child: Stack(
        children: [
          LinearProgressIndicator(
            value: 0.6,
            minHeight: 100,
            borderRadius: BorderRadius.circular(borderRadius),
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

  InkWell listSetting(BuildContext context) {
    return InkWell(
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
    );
  }
}

class EditableTitle extends StatelessWidget {
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
      selector: (context, provider) => provider.isEditingList,
      builder: (context, isEditing, child) {
        final listManager = Provider.of<MainListManager>(
          context,
          listen: false,
        );

        String changedTitle = listManager.getListTitle(widget.id);
        if (isEditing) {
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
                listManager.renameList(listManager.selectedId, newTitle);
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
