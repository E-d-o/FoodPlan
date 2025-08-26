import 'package:flutter/material.dart';
import 'package:foodplan/managers/single_list_manager.dart';

class HoldListItemBottomSheet extends StatelessWidget {
  const HoldListItemBottomSheet({
    super.key,
    required this.singleListManager,
    required this.id,
  });

  final SingleListManager singleListManager;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                singleListManager.renameItem(
                  id,
                  "sdfkj",
                ); //TODO:editable title in listitem
              },
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Rinomina"), Icon(Icons.edit_square)],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                singleListManager.removeItem(id);
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Eliminato")));
              },
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Elimina"), Icon(Icons.delete)],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                singleListManager.copyItem(id);
                Navigator.pop(context);
              },
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Copia"), Icon(Icons.copy_all_outlined)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
