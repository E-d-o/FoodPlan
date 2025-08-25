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
  late Future<Box> _boxFuture;

  @override
  void initState() {
    title = widget.givenTitle;
    textEditingController = TextEditingController(text: title);
    _openBox(widget.nameOfBox);

    super.initState();
  }

  void _openBox(String nameOfBox) async {
    _boxFuture = Hive.openBox(nameOfBox);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _boxFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text("Errore:${snapshot.error}");
        }
        //data is loaded

        if (!snapshot.hasData) {
          return Text("snapshot non ha data della box");
        }
        final Box box = snapshot.data!;
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),

          child: mainStructure(context, box),
        );
      },
    );
  }

  Widget mainStructure(BuildContext context, Box box) {
    double containerHeight = 100;
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
          FocusScope.of(context).unfocus();
          listManager.changeEditState(widget.id);
          textEditingController.text = currentTitle;
        }
      },
      child: SizedBox(
        height: containerHeight,
        width: double.infinity,
        child: Stack(
          children: [
            CustomProgressIndicator(
              borderRadius: borderRadius,
              height: containerHeight,

              id: widget.id,
            ),

            Main(
              box: box,
              containerHeight: containerHeight,
              textEditingController: textEditingController,
              widget: widget,
              titleStyle: titleStyle,
            ),
            Positioned(
              right: 0,
              top: 10,
              child: ListSetting(context: context, id: widget.id),
            ),
          ],
        ),
      ),
    );
  }
}

class ListSetting extends StatelessWidget {
  const ListSetting({super.key, required this.context, required this.id});

  final BuildContext context;

  final String id;

  @override
  Widget build(BuildContext context) {
    double inkBorderRadius = 5;
    MainListManager mainListManager = context.watch<MainListManager>();
    if (mainListManager.getEditStatus(id)) return SizedBox.shrink();
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
}

class Main extends StatelessWidget {
  const Main({
    super.key,
    required this.box,
    required this.containerHeight,
    required this.textEditingController,
    required this.widget,
    required this.titleStyle,
  });

  final Box box;
  final double containerHeight;
  final TextEditingController textEditingController;
  final MainList widget;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    MainListManager mainListManager = context.watch<MainListManager>();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor.withValues(alpha: 0.40),
        highlightColor: Colors.transparent,

        onTap: mainListManager.getEditStatus(widget.id)
            ? null //Disable inkwell onTap when editing, for some reason shows a darker color when onChanged text
            : () async {
                await Future.delayed(Duration(milliseconds: 200));
                if (!context.mounted) {
                  return; //check if widget is still in tree
                }
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
          padding: EdgeInsets.only(left: 20),
          height: containerHeight,
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

              RightPartMain(
                titleStyle: titleStyle,
                id: widget.id,
                controller: textEditingController,
              ),
            ],
          ),
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
      return Column(
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
      );
    }
  }
}
