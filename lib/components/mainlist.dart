import 'package:flutter/material.dart';
import 'package:foodplan/single_list_page.dart';

class MainList extends StatefulWidget {
  const MainList({super.key, required this.title});
  final String title;
  @override
  State<MainList> createState() => _MainListState();
}

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SingleListPage();
              },
            ),
          );
        },

        child: SizedBox(
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
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).showBottomSheet((
                          BuildContext context,
                        ) {
                          return Container(
                            width: double.infinity,
                            height: 300,

                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                          );
                        });
                      },
                      child: Icon(Icons.more_vert, size: 28),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
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
