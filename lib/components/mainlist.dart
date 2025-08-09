import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.redAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 4,
        children: [
          Container(
            padding: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.more_vert)],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nuova Lista",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text("0/0"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
