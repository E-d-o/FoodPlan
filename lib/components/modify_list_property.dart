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
            color: Colors.blue,
            border: BoxBorder.fromLTRB(
              right: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: Text("$propertyName:"),
        ),

        Expanded(
          child: Container(
            height: fieldHeight,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue),
            child: widget,
          ),
        ),
      ],
    );
  }
}
