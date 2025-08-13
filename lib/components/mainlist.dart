import 'package:flutter/material.dart';
import 'package:foodplan/components/main_list_bottom_sheet.dart';
import 'package:foodplan/pages/single_list_page.dart';

class MainList extends StatefulWidget {
  MainList({super.key});
  final SingleListPage myPage = SingleListPage();

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
      color: Colors.redAccent,
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

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 0,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [MainListSettings(isEditingName: isEditingName)],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [renameLogic(), Text("0/0")],
            ),
          ),
        ],
      ),
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
        child: TextField(
          controller: textEditingController,
          autofocus: true,
          onSubmitted: (value) {
            title = value;
            isEditingName.value = !isEditingName.value;
          },
        ),
      );
    } else {
      return Text(title, style: Theme.of(context).textTheme.bodyMedium);
    }
  }
}

class MainListSettings extends StatelessWidget {
  const MainListSettings({super.key, required this.isEditingName});
  final ValueNotifier isEditingName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          barrierColor: Colors.transparent,
          builder: (context) {
            return MainListBottomSheet(isEditingName: isEditingName);
          },
        );
      },
      child: Icon(Icons.more_vert, size: 28),
    );
  }
}
