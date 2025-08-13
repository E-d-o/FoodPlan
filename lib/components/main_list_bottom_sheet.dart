import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:provider/provider.dart';

class MainListBottomSheet extends StatelessWidget {
  const MainListBottomSheet({
    super.key,
    required this.isEditingName,
    required this.listIndex,
  });
  final ValueNotifier isEditingName;
  final int listIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  ),
                  onPressed: () {
                    isEditingName.value = !isEditingName.value;
                    Navigator.pop(context);
                  },
                  child: Text("Rinomina"),
                ),
              ),
              DeleteButton(listIndex: listIndex),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.listIndex});
  final int listIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
          foregroundColor: WidgetStatePropertyAll(Colors.black),

          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
        ),
        onPressed: () {
          final listManager = Provider.of<MainListManager>(
            context,
            listen: false,
          );
          print(listIndex);
          listManager.removeMainList(listIndex);
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Elimina Lista"),
            Icon(Icons.delete_outline_rounded, size: 28),
          ],
        ),
      ),
    );
  }
}
