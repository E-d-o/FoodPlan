import 'package:flutter/material.dart';
import 'package:foodplan/models/main_list_manager.dart';
import 'package:provider/provider.dart';

class SingleListBottomSheet extends StatelessWidget {
  const SingleListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final MainListManager mainListManager = context.read<MainListManager>();
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                mainListManager.removeMainList(mainListManager.selectedId);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Elimina lista",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Icon(Icons.delete, size: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
