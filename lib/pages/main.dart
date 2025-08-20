import 'package:flutter/material.dart';
import 'package:foodplan/components/add_main_list.dart';
import 'package:foodplan/notifiers/homepage_manager.dart';

import 'package:foodplan/notifiers/main_list_manager.dart';
import 'package:provider/provider.dart';
import 'drawer_page.dart';
import '../components/logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Color seedColor = const Color.fromARGB(255, 115, 203, 127);
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    return MaterialApp(
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

      darkTheme: ThemeData.dark(), //DarkTheme
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainListManager()),
          ChangeNotifierProvider(create: (context) => HomepageManager()),
        ],
        child: MyHomePage(title: 'FoodPlan'),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: add floating action button to go back up ONLY when i scrolled down and the appbar is not visible
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
    return Visibility(
      visible: homepageManager.isFloatingButtonVisible,
      child: FloatingActionButton(
        onPressed: () {
          homepageManager.scrollToTop();
        },
        child: Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}

//TODO: when i pop out of single list dont destroy and create another singlelistmanager provider or idk maybe with DB i just need to pull the data
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
