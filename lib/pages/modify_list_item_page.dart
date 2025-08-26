import 'dart:io';

import 'package:flutter/material.dart';

import 'package:foodplan/components/editable_title.dart';

import 'package:foodplan/components/properties.dart';

import 'package:foodplan/managers/single_list_manager.dart';
import 'package:foodplan/models/enums/single_list_property.dart';
import 'package:image_picker/image_picker.dart';

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
    final TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium
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
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10),
                      ),
                    ),
                    title: Row(children: [Text("Attenzione!")]),
                    content: Text("Vuoi veramente eliminare questo oggetto?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Annulla"),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                          ); //ATTENZIONE AL REBUILD DEL EDITABLETITLE PRIMA DEL POP, CAUSA ERRORI PERCHE REBUILDA ANCHE SE ID E' ELIMINATO
                          Navigator.pop(context);
                          singleListManager.removeItem(widget.id);

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Eliminato")));
                        },
                        child: Text(
                          "Elimina Definitivamente",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            scrollableContent(titleStyle, singleListManager, widget.id),
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
      ),
    );
  }

  SingleChildScrollView scrollableContent(
    TextStyle? titleStyle,
    SingleListManager singleListManager,
    String id,
  ) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 100),

        child: Column(
          spacing: 20,
          children: [
            EditImage(id: id),
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
                  SizedBox(height: 200),
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
  const EditImage({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    return Selector<SingleListManager, String>(
      builder: (context, value, child) {
        final String imagePath = value;
        if (imagePath == '') {
          //check if rebuild when deleted
          return SizedBox.shrink();
        }
        SingleListManager singleListManager = context.read<SingleListManager>();
        return Container(
          height: 320,
          padding: EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          child: Center(
            child: Stack(
              children: [
                showImage(imagePath),
                AddPitcure(singleListManager: singleListManager, id: id),
              ],
            ),
          ),
        );
      },
      selector: (context, provider) {
        try {
          return provider.getImagePath(id);
        } catch (e) {
          return '';
        }
      },
    );
    //SingleListManager singleListManager = context.watch<SingleListManager>();
    //optimization: rebuild on imagepath changing
  }

  Image showImage(String imagePath) {
    if (imagePath.startsWith("/")) {
      //se inizia con / allora e' un percorso nel file system, altrimenti e' un asset!
      return Image.file(File(imagePath));
    } else {
      return Image.asset(imagePath);
    }
  }
}

class AddPitcure extends StatelessWidget {
  const AddPitcure({
    super.key,
    required this.singleListManager,
    required this.id,
  });

  final SingleListManager singleListManager;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              singleListManager.setImage(id, ImageSource.camera);
            },
            icon: Icon(Icons.camera_alt),
          ),

          IconButton(
            onPressed: () {
              singleListManager.setImage(id, ImageSource.gallery);
            },
            icon: Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
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
              maxLength: 24,
              titleStyle: titleStyle,
              width: 400,
            ),
          ),
        ),
      ],
    );
  }
}
