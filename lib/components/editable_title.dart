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
    required this.textAlign,
    required this.maxLength,
    required this.titleStyle,
  });

  final TextEditingController textEditingController;
  final String id;
  final BuildContext context;
  final bool isAutofocused;
  final TextAlign textAlign;
  final int maxLength;
  final TextStyle? titleStyle;

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
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              enableInteractiveSelection: false,
              textAlign: textAlign,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: false,
              ),

              controller:
                  textEditingController, //TODO:when clicked outside it needs to rename to the old value, it saves only on submitted
              autofocus: isAutofocused,
              style: titleStyle,
              maxLength: maxLength,
              onSubmitted: (newTitle) {
                listManager.renameItem(id, newTitle);
              },
            ),
          );
        } else {
          return SizedBox(
            height: 28,
            child: Text(changedTitle, style: titleStyle),
          );
        }
      },
    );
  }
}
