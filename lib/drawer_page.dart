import 'package:flutter/material.dart';
import 'components/logo.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 27,
          children: [
            SizedBox(height: 10, width: double.infinity),
            Logo(),

            Row(
              spacing: 10,
              children: [
                Icon(Icons.settings_sharp),
                Text(
                  "Impostazioni",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [Icon(Icons.help_outline), Text("Aiuto")],
            ),
            Row(
              spacing: 10,
              children: [Icon(Icons.mail), Text("Invia Feedback")],
            ),
          ],
        ),
      ),
    );
  }
}
