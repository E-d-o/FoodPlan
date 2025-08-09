import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        Text("FoodPlan", style: Theme.of(context).textTheme.titleMedium),
        Icon(Icons.shopping_bag, color: Colors.black),
      ],
    );
  }
}
