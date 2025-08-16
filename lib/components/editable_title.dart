import 'package:flutter/material.dart';
import 'package:foodplan/notifiers/editable.dart';

import 'package:provider/provider.dart';

class EditableTitle<T extends Editable> extends StatelessWidget {
  //TODO: Fix max length of title
  const EditableTitle({
    super.key,
    required this.textEditingController,
    required this.id,
    required this.context,
    required this.isAutofocused,
  });

  final TextEditingController textEditingController;
  final String id;
  final BuildContext context;
  final bool isAutofocused;

  @override
  Widget build(BuildContext context) {
    return Selector<T, bool>(
      selector: (context, provider) => provider.getEditStatus(id),
      builder: (context, isEditing, child) {
        final listManager = Provider.of<T>(context, listen: false);
        String changedTitle = listManager.getTitle(id);
        if (listManager.getEditStatus(id)) {
          return SizedBox(
            width: 280,
            height: 24,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
              controller:
                  textEditingController, //TODO:when clicked outside it needs to rename to the old value, it saves only on submitted
              autofocus: true,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onSubmitted: (newTitle) {
                listManager.renameItem(id, newTitle);
              },
            ),
          );
        } else {
          return SizedBox(
            height: 24,
            child: Text(
              changedTitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        }
      },
    );
  }
}
