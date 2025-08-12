import 'package:flutter/material.dart';

class MainListBottomSheet extends StatelessWidget {
  const MainListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  ),
                  onPressed: () {},
                  child: Text("Rinomina"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),

                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Elimina Lista"),
                      Icon(Icons.delete_outline_rounded, size: 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
