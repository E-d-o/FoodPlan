import 'package:flutter/material.dart';
import 'package:foodplan/components/mainlist.dart';
import 'drawer_page.dart';
import 'components/logo.dart';

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
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontFamily: "Inter",
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(43, 140, 67, 1),
          brightness: Brightness.light,
        ),
      ),
      home: const MyHomePage(title: 'FoodPlan'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [Logo()],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,

        centerTitle: true,
      ),
      body: mainContent(),
    );
  }

  Container mainContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.amber,
      padding: EdgeInsets.all(15),
      child: Column(
        spacing: 15,
        children: [
          MainList(),
          MainList(),
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
