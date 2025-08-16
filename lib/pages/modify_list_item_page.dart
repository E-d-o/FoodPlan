import 'package:flutter/material.dart';
import 'package:foodplan/components/editable_title.dart';
import 'package:foodplan/notifiers/single_list_manager.dart';
import 'package:provider/provider.dart';

class ModifyListItemPage extends StatelessWidget {
  const ModifyListItemPage({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    final listItemManager = context.read<SingleListManager>();
    final String title = listItemManager.getTitle(id);
    final TextEditingController controller = TextEditingController(text: title);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              listItemManager.removeItem(id);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Eliminato")));
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: Container(
        color: Colors.amber,
        child: Column(
          spacing: 20,
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.only(
                right: 50,
                left: 50,
                top: 20,
                bottom: 20,
              ),
              child: Center(child: Placeholder()),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: EditableTitle<SingleListManager>(
                                textEditingController: controller,
                                id: id,
                                context: context,
                                isAutofocused: false,
                                textAlign: TextAlign.center,
                                maxLength: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
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
