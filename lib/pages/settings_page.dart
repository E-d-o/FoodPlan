import 'package:flutter/material.dart';
import 'package:foodplan/models/settings_manager.dart';
import 'package:provider/provider.dart';

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

  List<Widget> allSettings(BuildContext context) {
    List<Widget> allSettings = [
      LanguageSelect(),

      //OpenLastList(isSwitched: isSwitched),//TODO:IMPLEMENT
      PriceMeasurementUnitSelect(),
      Faq(),
      SendFeedback(),
    ];
    return allSettings;
  }
}

class PriceMeasurementUnitSelect extends StatelessWidget {
  const PriceMeasurementUnitSelect({super.key});

  List<DropdownMenuEntry<String>> getMeasurementUnits() {
    List<String> avaliableUnits = SettingsManager.availablePriceUnits;
    List<DropdownMenuEntry<String>> dropdownList = [];

    for (var element in avaliableUnits) {
      dropdownList.add(DropdownMenuEntry(value: element, label: element));
    }
    return dropdownList;
  }

  @override
  Widget build(BuildContext context) {
    SettingsManager settingsManager = context.watch<SettingsManager>();
    return ListTile(
      leading: Text(
        "Unità di misura del prezzo:",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: DropdownMenu(
        width: 100,
        initialSelection: settingsManager.priceMeasurementUnit,
        dropdownMenuEntries: getMeasurementUnits(),
        onSelected: (value) {
          if (value != null) {
            settingsManager.setPriceMeasurementUnit(value.toString());
          }
        },
      ),
    );
  }
}

class SendFeedback extends StatelessWidget {
  const SendFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "Segnala un problema",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Icon(Icons.arrow_outward_sharp, size: 24, color: Colors.black),
      onTap: () {},
    );
  }
}

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "Vai alle FAQ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Icon(Icons.arrow_outward_sharp, size: 24, color: Colors.black),
      onTap: () {},
    );
  }
}

class OpenLastList extends StatelessWidget {
  const OpenLastList({super.key, required this.isSwitched});

  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "Apri l'ultima lista all'apertura:",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Switch(value: isSwitched, onChanged: (value) {}),
    );
  }
}

class LanguageSelect extends StatelessWidget {
  const LanguageSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
