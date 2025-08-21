import 'package:flutter/material.dart';

import 'package:foodplan/components/editable_title.dart';

import 'package:foodplan/components/properties.dart';

import 'package:foodplan/managers/single_list_manager.dart';
import 'package:foodplan/models/enums/single_list_property.dart';

import 'package:provider/provider.dart';

class ModifyListItemPage extends StatefulWidget {
  const ModifyListItemPage({super.key, required this.id});
  final String id;

  @override
  State<ModifyListItemPage> createState() => _ModifyListItemPageState();
}

class _ModifyListItemPageState extends State<ModifyListItemPage> {
  late TextEditingController controller;
  @override
  void initState() {
    final String title = context.read<SingleListManager>().getProperty(
      widget.id,
      SingleListProperty.title,
    );
    controller = TextEditingController(text: title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final singleListManager = context.read<SingleListManager>();
    final TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            singleListManager.undoChanges(widget.id);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              ); //ATTENZIONE AL REBUILD DEL EDITABLETITLE PRIMA DEL POP, CAUSA ERRORI PERCHE REBUILDA ANCHE SE ID E' ELIMINATO
              singleListManager.removeItem(widget.id);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Eliminato")));
            },
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          scrollableContent(titleStyle, singleListManager),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  onPressed: () {
                    singleListManager.notifyChange();
                    Navigator.pop(context);
                  },
                  child: Text("Salva"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView scrollableContent(
    TextStyle? titleStyle,
    SingleListManager singleListManager,
  ) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 100),

        child: Column(
          spacing: 20,
          children: [
            EditImage(),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.secondaryContainer, //Background
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  ModifyTitle(
                    controller: controller,
                    widget: widget,
                    titleStyle: titleStyle,
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Properties(id: widget.id),
                  ),
                  SizedBox(height: 300),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditImage extends StatelessWidget {
  const EditImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
      child: Center(child: Placeholder()),
    );
  }
}

class ModifyTitle extends StatelessWidget {
  const ModifyTitle({
    super.key,
    required this.controller,
    required this.widget,
    required this.titleStyle,
  });

  final TextEditingController controller;
  final ModifyListItemPage widget;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            border: Border(bottom: BorderSide(color: Colors.black, width: 2.0)),
          ),
          child: Center(
            child: EditableTitle<SingleListManager>(
              textEditingController: controller,
              id: widget.id,
              context: context,
              isAutofocused: false,
              textAlign: TextAlign.center,
              maxLength: 20,
              titleStyle: titleStyle,
            ),
          ),
        ),
      ],
    );
  }
}
