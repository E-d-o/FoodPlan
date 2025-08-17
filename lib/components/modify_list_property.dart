import 'package:flutter/material.dart';

class ModifyListProperty extends StatelessWidget {
  const ModifyListProperty({
    super.key,
    required this.propertyName,
    required this.widget,
  });
  final String propertyName;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 40),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: BoxBorder.fromLTRB(
            right: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        child: Text(propertyName + ":"),
      ),

      title: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.blue),
        child: widget,
      ),
    );
  }
}
