import 'package:flutter/material.dart';
import 'package:foodplan/components/custom_progress_indicator.dart';
import 'package:foodplan/components/editable_title.dart';
import 'package:foodplan/managers/single_list_manager.dart';

import 'package:foodplan/pages/main_list_bottom_sheet.dart';
import 'package:foodplan/managers/main_list_manager.dart';
import 'package:foodplan/pages/single_list_page.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';

class MainList extends StatefulWidget {
  const MainList({
    super.key,
    required this.id,
    this.givenTitle = "Nuova lista",
    required this.nameOfBox,
  });
  final String givenTitle;
  final String id;
  final String nameOfBox;

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  late String title;
  late TextEditingController textEditingController;
  final double borderRadius = 10.0;
  late final Box box;

  @override
  void initState() {
    title = widget.givenTitle;
    textEditingController = TextEditingController(text: title);
    openBox(widget.nameOfBox);

    super.initState();
  }

  void openBox(String nameOfBox) async {
    box = await Hive.openBox(nameOfBox);
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

  Widget mainStructure(BuildContext context) {
    double boxHeight = 100;
    final MainListManager listManager = context.read<MainListManager>();
    final String currentTitle = listManager.getTitle(widget.id);
    textEditingController.text = currentTitle;
    final TextStyle? titleStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onPrimary);

    return TapRegion(
      onTapInside: (event) {},
      onTapOutside: (event) {
        //handles editing status of title
        if (listManager.getEditStatus(widget.id)) {
          print("tappato fuori");
          FocusScope.of(context).unfocus();
          listManager.changeEditState(widget.id);
          textEditingController.text = currentTitle;
        }
      },
      child: SizedBox(
        height: boxHeight,
        width: double.infinity,
        child: Stack(
          children: [
            CustomProgressIndicator(
              borderRadius: borderRadius,
              height: boxHeight,

              id: widget.id,
            ),

            GestureDetector(
              onTap: () {
                //TODO: FIX is only clickable on title, maybe do a stack with options and make all the things under clickable
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) => SingleListManager(box: box),
                        builder: (context, child) => SingleListPage(),
                      );
                    },
                  ),
                );
              },
              child: Container(
                height: boxHeight,
                padding: EdgeInsets.only(left: 18, right: 4, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    RightPartMain(
                      titleStyle: titleStyle,
                      id: widget.id,
                      controller: textEditingController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightPartMain extends StatelessWidget {
  const RightPartMain({
    super.key,
    required this.titleStyle,
    required this.id,
    required this.controller,
  });

  final TextStyle? titleStyle;
  final String id;
  final TextEditingController controller;

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
          listManager.selectedId = id;

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

  @override
  Widget build(BuildContext context) {
    final MainListManager listManager = context.watch<MainListManager>();
    if (listManager.getEditStatus(id)) {
      return ElevatedButton(
        onPressed: () {
          listManager.renameItem(id, controller.text);
        },
        child: Icon(Icons.check),
      );
    } else {
      return Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  //TODO: use mainlistProperty to show proper value
                  "0/0",
                  style: titleStyle,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [listSetting(context)],
          ),
        ],
      );
    }
  }
}
