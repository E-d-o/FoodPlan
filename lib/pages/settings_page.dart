import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(
              child: Text(
                "Impostazioni",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 10),
            ...allSettings(context),
          ],
        ),
      ),
    );
  }

  List<ListTile> allSettings(BuildContext context) {
    List<ListTile> allSettings = [];

    allSettings = [
      ListTile(
        leading: Text("Lingua:", style: Theme.of(context).textTheme.bodyMedium),
        trailing: DropdownButton(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          items: [
            DropdownMenuItem(
              child: Text(
                "Italiano",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
          onChanged: (value) {},
        ),
      ),
      ListTile(
        leading: Text(
          "Apri l'ultima lista all'apertura:",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
        ),
      ),
      ListTile(
        leading: Text(
          "Vai alle FAQ",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Icon(
          Icons.arrow_outward_sharp,
          size: 24,
          color: Colors.black,
        ),
        onTap: () {},
      ),
      ListTile(
        leading: Text(
          "Segnala un problema",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Icon(
          Icons.arrow_outward_sharp,
          size: 24,
          color: Colors.black,
        ),
        onTap: () {},
      ),
    ];
    return allSettings;
  }
}
