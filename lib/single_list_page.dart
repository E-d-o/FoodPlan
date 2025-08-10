import 'package:flutter/material.dart';

class SingleListPage extends StatefulWidget {
  const SingleListPage({super.key});

  @override
  State<SingleListPage> createState() => _SingleListPageState();
}

class _SingleListPageState extends State<SingleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [SizedBox(height: 500, width: 500)]),
    );
  }
}
