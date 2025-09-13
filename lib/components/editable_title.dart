import 'package:flutter/material.dart';
import 'package:foodplan/components/editable.dart';
import 'package:foodplan/controllers/main_list_controller.dart';

import 'package:foodplan/models/single_list_manager.dart';
import 'package:foodplan/properties/enums/single_list_property.dart';

import 'package:provider/provider.dart';

class EditableTitle<T extends Editable> extends StatelessWidget {
  const EditableTitle({
    super.key,
    required this.textEditingController,
    required this.id,
    required this.context,
    required this.isAutofocused,
    required this.textAlign,
    required this.maxLength,
    required this.titleStyle,
    this.width = 300,
  });

  final TextEditingController textEditingController;
  final String id;
  final BuildContext context;
  final bool isAutofocused;
  final TextAlign textAlign;
  final int maxLength;
  final TextStyle? titleStyle;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Selector<T, bool>(
      selector: (context, provider) => provider.getEditStatus(id),
      builder: (context, isEditing, child) {
        final listManager = context.read<T>();
        String changedTitle = listManager.getTitle(id);
        if (listManager.getEditStatus(id)) {
          return SizedBox(
            width: width,
            height: 28,
            child: TextField(
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              enableInteractiveSelection: false,
              textAlign: textAlign,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                counterText: "",
                isCollapsed: true,
              ),

              controller: textEditingController,
              autofocus: isAutofocused,
              style: titleStyle,
              maxLength: maxLength,
              onSubmitted: (newTitle) {
                listManager.renameItem(id, newTitle);
              },

              onTapOutside: (event) async {
                switch (listManager) {
                  case SingleListManager():
                    FocusScope.of(context).unfocus();
                    listManager.saveProperty(
                      id,
                      SingleListProperty.title,
                      textEditingController.text,
                      isPermanent: false,
                    );
                    break;
                  case MainListController():
                }
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
