import 'package:flutter/material.dart';
import '../components/logo.dart';

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

            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.settings_sharp,
                size: 24,
                color: Colors.black,
                weight: 50.0,
              ),
              title: Text(
                "Impostazioni",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.help,
                size: 24,
                color: Colors.black,
                weight: 50.0,
              ),
              title: Text(
                "Aiuto",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.mail,
                size: 24,
                color: Colors.black,
                weight: 50.0,
              ),
              title: Text(
                "Invia Feedback",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
