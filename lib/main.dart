import 'package:flutter/material.dart';
import 'package:foodplan/components/add_main_list.dart';
import 'package:foodplan/controllers/homepage_controller.dart';
import 'package:foodplan/managers/homepage_manager.dart';
import 'package:foodplan/managers/main_list_manager.dart';
import 'package:foodplan/managers/settings_manager.dart';
import 'package:foodplan/models/main_list_properties.dart';
import 'package:foodplan/models/single_list_properties.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'pages/drawer_page.dart';
import '../components/logo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MainListPropertiesAdapter());
  Hive.registerAdapter(SingleListPropertiesAdapter());

  await Hive.openBox("mainlist");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final SettingsManager settingsManager = SettingsManager();
    final Color seedColor = const Color.fromARGB(255, 147, 205, 119);
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: settingsManager,
        ), //pass as value so i can pass it so mainlistmanager aswell
        ChangeNotifierProvider(
          create: (context) =>
              MainListManager(settingsManager: settingsManager),
        ),
      ],
      child: MaterialApp(
        title: 'FoodPlan',
        theme: ThemeData(
          fontFamily: "Roboto",
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            titleMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          colorScheme: colorScheme,
          splashColor: colorScheme.onPrimary,
          scaffoldBackgroundColor: null,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),

        // darkTheme: ThemeData.dark(), //DarkTheme
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomepageManager()),
             ProxyProvider<HomepageManager, HomepageController>(
              update: (context, homepageManager, previous) => 
                HomepageController(homepageManager: homepageManager),
            ),
          ],
          child: MyHomePage(title: 'FoodPlan'),
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HidableActionButton(),

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: DrawerPage(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          Logo(
            onBackgroundColor: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actionsPadding: EdgeInsets.symmetric(horizontal: 12),
        centerTitle: true,
      ),
      body: _MainContent(),
    );
  }
}

class HidableActionButton extends StatelessWidget {
  const HidableActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    HomepageManager homepageManager = context.watch<HomepageManager>();
    HomepageController controller = context.read<HomepageController>();
    return Visibility(
      visible: homepageManager.isFloatingButtonVisible,
      child: FloatingActionButton(
        onPressed: () {
          controller.scrollToTop();
        },
        child: Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    final listManager = Provider.of<MainListManager>(context, listen: true);
    return SingleChildScrollView(
      controller: context.read<HomepageManager>().scrollController,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 15,
        children: [
          ...listManager.mainListPages,
          (AddMainList()),
          SizedBox(height: 400),
        ],
      ),
    );
  }
}
