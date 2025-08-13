import 'package:flutter/material.dart';
import 'package:foodplan/components/main_list_bottom_sheet.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:foodplan/pages/single_list_page.dart';
import 'package:provider/provider.dart';

class MainList extends StatefulWidget {
  MainList({super.key, required this.listIndex});
  final SingleListPage myPage = SingleListPage();
  final int listIndex;

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  String title = "Nuova Lista";
  final isEditingName = ValueNotifier(false);
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.text = title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.0),

      child: InkResponse(
        //makes the ink splash bound to the cointainer which is a rectangle with circular radius 10.0
        splashColor: Theme.of(context).splashColor,

        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
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
          LinearProgressIndicator(value: 0.6, minHeight: 100),

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
        showModalBottomSheet(
          showDragHandle: true,
          context: context,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          barrierColor: Colors.transparent,
          builder: (context) {
            return ChangeNotifierProvider.value(
              value: listManager,
              child: MainListBottomSheet(
                isEditingName: isEditingName,
                listIndex: widget.listIndex,
              ),
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
            title = value;
            isEditingName.value = !isEditingName.value;
          },
        ),
      );
    } else {
      return SizedBox(
        height: 24,
        child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      );
    }
  }
}
