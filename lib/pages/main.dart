import 'package:flutter/material.dart';
import 'package:foodplan/components/add_main_list.dart';
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
    return MaterialApp(
      title: 'FoodPlan',
      theme: ThemeData(
        fontFamily: "Roboto",
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        splashColor: Colors.amber,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(43, 140, 67, 1),
          brightness: Brightness.light,
        ),
      ),
      home: ChangeNotifierProvider(
        create: (context) => MainListManager(),

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
      drawer: DrawerPage(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [Logo()],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actionsPadding: EdgeInsets.symmetric(horizontal: 12),
        centerTitle: true,
      ),
      body: _MainContent(),
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listManager = Provider.of<MainListManager>(context, listen: true);
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 15,
        children: [...listManager.mainListPages, (AddMainList())],
      ),
    );
  }
}
