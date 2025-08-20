import 'package:flutter/material.dart';

class ModifyListProperty extends StatelessWidget {
  const ModifyListProperty({
    super.key,
    required this.propertyName,
    required this.widget,
    this.fieldHeight,
  });
  final String propertyName;
  final TextField widget;
  final double? fieldHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            border: BoxBorder.fromLTRB(
              right: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: Text(
            "$propertyName:",
            style: (Theme.of(context).textTheme.titleSmall)!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: fieldHeight,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: widget,
          ),
        ),
      ],
    );
  }
}
