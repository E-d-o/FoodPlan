import 'package:flutter/material.dart';
import 'package:foodplan/pages/settings_page.dart';
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
          spacing: 18,
          children: [
            SizedBox(height: 20, width: double.infinity),
            Logo(),
            SizedBox(height: 1, width: double.infinity),
            ListTile(
              splashColor: Theme.of(context).splashColor,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage();
                    },
                  ),
                );
              },
            ),
            ListTile(
              splashColor: Theme.of(context).splashColor,
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
              splashColor: Theme.of(context).splashColor,
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
