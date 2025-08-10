import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}
/*
class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("DKFJK", style: Theme.of(context).textTheme.bodyMedium),
          Text("sdfdskfj"),
        ],
      ),

      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.more_vert),
          Container(
            child: Text("0/0", style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
      tileColor: Colors.blueAccent,
      contentPadding: EdgeInsets.all(20),
    );
  }
}



*/

class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(10.0),

      child: InkResponse(
        //makes the ink splash bound to the cointainer which is a rectangle with circular radius 10.0
        splashColor: Colors.teal,
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        containedInkWell: true,
        //end of ink splash section
        onTap: () {
          print("object");
        },

        child: Container(
          height: 100,
          width: double.infinity,

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
                padding: EdgeInsets.symmetric(horizontal: 18),
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
        ),
      ),
    );
  }
}
