import 'package:flutter/material.dart';
import 'package:foodplan/components/main_list_bottom_sheet.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:foodplan/pages/single_list_page.dart';
import 'package:provider/provider.dart';

class MainList extends StatefulWidget {
  MainList({super.key, required this.id, this.title = "Nuova lista"});

  final SingleListPage myPage = SingleListPage();
  final String id;
  String title = "Nuova lista";

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  final isEditingName = ValueNotifier(false);
  TextEditingController textEditingController = TextEditingController();
  final double borderRadius = 10.0;
  @override
  void initState() {
    textEditingController.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                return widget.myPage;
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
                    renameLogic(),
                    Text("0/0"),
                  ], //TODO: refactor con nuova classe editable title
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
        print(listManager.selectedId);
        showModalBottomSheet(
          showDragHandle: true,
          context: context,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          barrierColor: Colors.transparent,
          builder: (context) {
            return ChangeNotifierProvider.value(
              value: listManager,
              child: MainListBottomSheet(isEditingName: isEditingName),
            );
          },
        );
      },
      child: Icon(Icons.more_vert, size: 28),
    );
  }

  ValueListenableBuilder<bool> renameLogic() {
    return ValueListenableBuilder(
      valueListenable: isEditingName,
      builder: (context, editValue, child) {
        return editingElement(editValue, context);
      },
    );
  }

  Widget editingElement(bool editValue, BuildContext context) {
    if (editValue) {
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
          onSubmitted: (value) {
            widget.title = value;
            isEditingName.value = !isEditingName.value;
          },
        ),
      );
    } else {
      return SizedBox(
        height: 24,
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
  }
}
