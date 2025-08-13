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
  final title = ValueNotifier("Nuova Lista");
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
              children: [MainListSettings(titleNotifier: title)],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: title,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),
                Text("0/0"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainListSettings extends StatelessWidget {
  const MainListSettings({super.key, required this.titleNotifier});
  final ValueNotifier titleNotifier;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          barrierColor: Colors.transparent,
          builder: (context) {
            return MainListBottomSheet(titleNotifier: titleNotifier);
          },
        );
      },
      child: Icon(Icons.more_vert, size: 28),
    );
  }
}
